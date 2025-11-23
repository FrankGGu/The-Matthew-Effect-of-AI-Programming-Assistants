#include <stdlib.h> // For malloc, free
#include <limits.h> // For LLONG_MIN
#include <uthash.h> // Assuming uthash is available on LeetCode for C solutions

typedef struct {
    int key;             // The value nums[i]
    long long value;     // The minimum P[i] encountered for this nums[i]
    UT_hash_handle hh;  // Makes this structure hashable
} HashEntry;

HashEntry *find_entry(HashEntry **map, int key) {
    HashEntry *s;
    HASH_FIND_INT(*map, &key, s);
    return s;
}

void add_or_update_entry(HashEntry **map, int key, long long val) {
    HashEntry *s = find_entry(map, key);
    if (s == NULL) {
        s = (HashEntry *)malloc(sizeof(HashEntry));
        s->key = key;
        s->value = val;
        HASH_ADD_INT(*map, key, s);
    } else {
        // Only update if the new prefix sum is smaller
        if (val < s->value) {
            s->value = val;
        }
    }
}

void free_map(HashEntry **map) {
    HashEntry *current_entry, *tmp;
    HASH_ITER(hh, *map, current_entry, tmp) {
        HASH_DEL(*map, current_entry);
        free(current_entry);
    }
    *map = NULL; // Ensure the pointer is set to NULL after freeing
}

long long maximumGoodSubarraySum(int* nums, int numsSize, int k) {
    // Initialize max_sum to the smallest possible long long value.
    // The problem guarantees at least one good subarray, so max_sum will be updated.
    long long max_sum = LLONG_MIN;

    // Calculate prefix sums
    // P[i] stores the sum of nums[0]...nums[i-1]
    // P[0] = 0
    // P[i+1] = P[i] + nums[i]
    long long* P = (long long*)malloc(sizeof(long long) * (numsSize + 1));
    P[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        P[i+1] = P[i] + nums[i];
    }

    // Hash map to store minimum P[idx] for each nums[idx] value.
    // This map will help find the minimum prefix sum for a required starting element.
    HashEntry *min_prefix_map = NULL;

    // Iterate through nums, considering each element nums[j] as the right endpoint
    // of a potential good subarray.
    for (int j = 0; j < numsSize; j++) {
        // Add the current element's prefix sum P[j] to the map.
        // This makes P[j] available for future subarrays starting at index j,
        // or for subarrays ending at j where the start element nums[i] equals nums[j] (i.e., i=j, k=0).
        // P[j] is the sum of nums[0]...nums[j-1].
        add_or_update_entry(&min_prefix_map, nums[j], P[j]);

        long long current_prefix_sum_up_to_j = P[j+1]; // Sum of nums[0]...nums[j]

        // Check for target1: nums[i] == nums[j] - k
        int target1 = nums[j] - k;
        HashEntry *s1 = find_entry(&min_prefix_map, target1);
        if (s1 != NULL) {
            // If target1 is found, calculate the subarray sum: P[j+1] - P[i]
            long long current_subarray_sum = current_prefix_sum_up_to_j - s1->value;
            if (current_subarray_sum > max_sum) {
                max_sum = current_subarray_sum;
            }
        }

        // Check for target2: nums[i] == nums[j] + k
        int target2 = nums[j] + k;
        HashEntry *s2 = find_entry(&min_prefix_map, target2);
        if (s2 != NULL) {
            // If target2 is found, calculate the subarray sum: P[j+1] - P[i]
            long long current_subarray_sum = current_prefix_sum_up_to_j - s2->value;
            if (current_subarray_sum > max_sum) {
                max_sum = current_subarray_sum;
            }
        }
    }

    // Free allocated memory
    free(P);
    free_map(&min_prefix_map);

    return max_sum;
}