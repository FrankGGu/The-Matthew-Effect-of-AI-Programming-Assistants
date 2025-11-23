#include <stdlib.h>
#include <string.h>
#include <time.h> // Required for srand, though typically handled by LeetCode test environment
#include <limits.h> // For INT_MAX, not used in final randomized solution

#define MAX_VAL_PLUS_ONE 20001

typedef struct {
    int* arr;
    int arr_size;
    int** val_indices; // Array of pointers to arrays, val_indices[value] stores sorted indices of 'value'
    int* val_indices_sizes; // val_indices_sizes[value] stores the number of occurrences of 'value'
} MajorityChecker;

int count_in_range(MajorityChecker* obj, int val, int left, int right) {
    if (val < 0 || val >= MAX_VAL_PLUS_ONE || obj->val_indices_sizes[val] == 0) {
        return 0;
    }

    int* indices = obj->val_indices[val];
    int size = obj->val_indices_sizes[val];

    // Find the first index in 'indices' that is >= 'left' (lower_bound)
    int low = 0, high = size - 1, first_occurrence_idx = size;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (indices[mid] >= left) {
            first_occurrence_idx = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    // Find the first index in 'indices' that is > 'right' (upper_bound)
    low = 0; high = size - 1; int last_occurrence_idx = size;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (indices[mid] > right) {
            last_occurrence_idx = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return last_occurrence_idx - first_occurrence_idx;
}

MajorityChecker* majorityCheckerCreate(int* arr, int arrSize) {
    MajorityChecker* obj = (MajorityChecker*)malloc(sizeof(MajorityChecker));
    obj->arr = (int*)malloc(sizeof(int) * arrSize);
    memcpy(obj->arr, arr, sizeof(int) * arrSize);
    obj->arr_size = arrSize;

    obj->val_indices = (int**)malloc(sizeof(int*) * MAX_VAL_PLUS_ONE);
    obj->val_indices_sizes = (int*)calloc(MAX_VAL_PLUS_ONE, sizeof(int)); // Initialize all sizes to 0

    // First pass: count occurrences of each value to determine array sizes
    for (int i = 0; i < arrSize; ++i) {
        obj->val_indices_sizes[arr[i]]++;
    }

    // Allocate memory for each individual val_indices array
    for (int i = 0; i < MAX_VAL_PLUS_ONE; ++i) {
        if (obj->val_indices_sizes[i] > 0) {
            obj->val_indices[i] = (int*)malloc(sizeof(int) * obj->val_indices_sizes[i]);
        } else {
            obj->val_indices[i] = NULL; // No occurrences, no memory needed
        }
    }

    // Second pass: fill the val_indices arrays with actual indices
    // Use a temporary array to track current fill positions for each value
    int* current_fill_indices = (int*)calloc(MAX_VAL_PLUS_ONE, sizeof(int));
    for (int i = 0; i < arrSize; ++i) {
        int val = arr[i];
        obj->val_indices[val][current_fill_indices[val]] = i;
        current_fill_indices[val]++;
    }
    free(current_fill_indices);

    // Seed the random number generator once.
    // LeetCode test environment might handle this, but including it for completeness.
    // Using a fixed seed for testing might be useful, but time(NULL) for actual randomness.
    srand(time(NULL)); 

    return obj;
}

#define NUM_RANDOM_TRIALS 20 // Number of random samples to check

int majorityCheckerQuery(MajorityChecker* obj, int left, int right, int threshold) {
    int range_len = right - left + 1;

    // Optimization for small thresholds or impossible thresholds
    if (threshold == 1) {
        return obj->arr[left]; // Any element in range satisfies threshold 1
    }
    if (threshold > range_len) {
        return -1; // No element can have frequency > range_len
    }

    for (int i = 0; i < NUM_RANDOM_TRIALS; ++i) {
        // Generate a random index within the query range [left, right]
        int random_offset = rand() % range_len;
        int random_idx = left + random_offset;

        int candidate_val = obj->arr[random_idx];

        // Count the actual frequency of the candidate_val in the range
        int freq = count_in_range(obj, candidate_val, left, right);

        if (freq >= threshold) {
            return candidate_val;
        }
    }

    // If after NUM_RANDOM_TRIALS no candidate is found, return -1.
    // This approach has a small probability of error if a majority element exists
    // but is not picked in any trial, especially if threshold is small relative to range_len.
    // However, it's a common and often accepted solution for this problem on LeetCode.
    return -1;
}

void majorityCheckerFree(MajorityChecker* obj) {
    free(obj->arr);
    for (int i = 0; i < MAX_VAL_PLUS_ONE; ++i) {
        if (obj->val_indices[i] != NULL) {
            free(obj->val_indices[i]);
        }
    }
    free(obj->val_indices);
    free(obj->val_indices_sizes);
    free(obj);
}