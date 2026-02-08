#include <stdlib.h>
#include <limits.h>

typedef struct {
    int start;
    int end;
    int len;
} Subarray;

int compareSubarrays(const void *a, const void *b) {
    Subarray *sa = (Subarray *)a;
    Subarray *sb = (Subarray *)b;
    if (sa->end != sb->end) {
        return sa->end - sb->end;
    }
    return sa->start - sb->start;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int minSumOfLengths(int* arr, int arrSize, int target) {
    // Step 1: Find all subarrays with sum target using a sliding window
    Subarray* found_subarrays = (Subarray*)malloc(arrSize * sizeof(Subarray));
    if (found_subarrays == NULL) {
        return -1; 
    }
    int num_found = 0;

    long long current_sum = 0;
    int left = 0;
    for (int right = 0; right < arrSize; ++right) {
        current_sum += arr[right];
        while (current_sum > target && left <= right) {
            current_sum -= arr[left];
            left++;
        }
        if (current_sum == target) {
            found_subarrays[num_found].start = left;
            found_subarrays[num_found].end = right;
            found_subarrays[num_found].len = right - left + 1;
            num_found++;
        }
    }

    if (num_found < 2) {
        free(found_subarrays);
        return -1;
    }

    // Step 2: Sort found_subarrays by end index, then by start index
    qsort(found_subarrays, num_found, sizeof(Subarray), compareSubarrays);

    // Step 3: Dynamic Programming - min_len_prefix[i] stores the minimum length of a subarray
    // with sum target among found_subarrays[0...i]
    int* min_len_prefix = (int*)malloc(num_found * sizeof(int));
    if (min_len_prefix == NULL) {
        free(found_subarrays);
        return -1;
    }

    min_len_prefix[0] = found_subarrays[0].len;
    for (int i = 1; i < num_found; ++i) {
        min_len_prefix[i] = min(min_len_prefix[i-1], found_subarrays[i].len);
    }

    // Step 4: Find minimum total length of two non-overlapping subarrays
    int overall_min_len_sum = INT_MAX;

    // Iterate through found_subarrays, considering each as the second subarray (sub2)
    for (int j = 1; j < num_found; ++j) {
        Subarray sub2 = found_subarrays[j];

        // Binary search for the best first subarray (sub1) that ends before sub2.start
        // We need to find the largest index 'k' such that found_subarrays[k].end < sub2.start
        int low = 0;
        int high = j - 1;
        int best_k = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (found_subarrays[mid].end < sub2.start) {
                best_k = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        if (best_k != -1) {
            // If a valid first subarray is found, update overall_min_len_sum
            overall_min_len_sum = min(overall_min_len_sum, min_len_prefix[best_k] + sub2.len);
        }
    }

    free(found_subarrays);
    free(min_len_prefix);

    return overall_min_len_sum == INT_MAX ? -1 : overall_min_len_sum;
}