#include <stdbool.h>
#include <stdlib.h> // For malloc, free, llabs

#include "uthash.h"

typedef struct {
    long long bucket_id; // Key for the hash table
    long long value;     // The number stored in this bucket
    UT_hash_handle hh;   // Makes this structure hashable
} BucketEntry;

long long get_bucket_id(long long val, long long t_plus_1) {
    if (val >= 0) {
        return val / t_plus_1;
    } else {
        // For negative numbers, standard C integer division truncates towards zero.
        // To achieve floor division (e.g., -1/2 = -1, -2/2 = -1, -3/2 = -2),
        // we can use the formula (val + 1) / divisor - 1.
        return (val + 1) / t_plus_1 - 1;
    }
}

bool containsNearbyAlmostDuplicate(int* nums, int numsSize, int k, int t) {
    if (numsSize < 2 || k < 0 || t < 0) {
        return false;
    }
    // If k is 0, abs(i - j) <= 0 implies i == j.
    // But the problem requires distinct indices i and j.
    if (k == 0) {
        return false;
    }

    BucketEntry *buckets = NULL; // Head of the hash table (UTHASH convention)

    // t_plus_1 is the size of each bucket range. Using long long to prevent overflow
    // if t is INT_MAX (2^31 - 1), then t+1 would exceed INT_MAX.
    long long t_plus_1 = (long long)t + 1;

    for (int i = 0; i < numsSize; ++i) {
        long long current_num = (long long)nums[i];
        long long b = get_bucket_id(current_num, t_plus_1);

        BucketEntry *entry;

        // 1. Check the bucket corresponding to current_num (bucket 'b')
        // If a number is already in the same bucket, their absolute difference
        // is guaranteed to be <= t because the bucket size is t+1.
        HASH_FIND_LONG(buckets, &b, entry);
        if (entry != NULL) {
            return true;
        }

        // 2. Check the adjacent bucket 'b-1'
        // If a number exists in an adjacent bucket, we need to explicitly check
        // if its absolute difference with current_num is <= t.
        long long b_minus_1 = b - 1;
        HASH_FIND_LONG(buckets, &b_minus_1, entry);
        if (entry != NULL && llabs(current_num - entry->value) <= t) {
            return true;
        }

        // 3. Check the adjacent bucket 'b+1'
        long long b_plus_1 = b + 1;
        HASH_FIND_LONG(buckets, &b_plus_1, entry);
        if (entry != NULL && llabs(current_num - entry->value) <= t) {
            return true;
        }

        // Add current_num to its bucket 'b'
        entry = (BucketEntry*)malloc(sizeof(BucketEntry));
        entry->bucket_id = b;
        entry->value = current_num;
        HASH_ADD_LONG(buckets, bucket_id, entry); // Add to hash table with bucket_id as key

        // Maintain the sliding window of size k.
        // Elements older than k distance from the current index i should be removed.
        // The window contains elements from index [i - k, i - 1] for comparison with nums[i].
        // So, when processing nums[i], we remove nums[i - k] from the map.
        if (i >= k) {
            long long old_num = (long long)nums[i - k];
            long long old_b = get_bucket_id(old_num, t_plus_1);

            HASH_FIND_LONG(buckets, &old_b, entry);
            if (entry != NULL) { // Should always be found if it was added
                HASH_DEL(buckets, entry); // Remove from hash table
                free(entry);             // Free the allocated memory
            }
        }
    }

    // Clean up any remaining hash table entries at the end
    BucketEntry *current_entry, *tmp;
    HASH_ITER(hh, buckets, current_entry, tmp) {
        HASH_DEL(buckets, current_entry);
        free(current_entry);
    }

    return false;
}