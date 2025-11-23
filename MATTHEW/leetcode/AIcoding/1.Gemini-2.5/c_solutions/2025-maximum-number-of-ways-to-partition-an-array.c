#include <stdlib.h> // For malloc, free, calloc
#include <stdio.h>  // Not strictly needed for solution, but useful for debugging

#define HASH_MAP_CAPACITY 100003 

typedef struct Entry {
    long long key;
    int value;
    struct Entry *next;
} Entry;

typedef struct {
    Entry **buckets;
} HashMap;

unsigned int hash(long long key) {
    // A common way to hash long long by mixing its upper and lower bits.
    // Handles negative keys by treating them as unsigned for hashing.
    return (unsigned int)(((unsigned long long)key >> 32) ^ (unsigned long long)key) % HASH_MAP_CAPACITY;
}

void initHashMap(HashMap *map) {
    map->buckets = (Entry **)calloc(HASH_MAP_CAPACITY, sizeof(Entry *));
    // calloc initializes memory to zero, so all bucket pointers are NULL
}

int get(HashMap *map, long long key) {
    unsigned int bucket_idx = hash(key);
    Entry *entry = map->buckets[bucket_idx];
    while (entry != NULL) {
        if (entry->key == key) {
            return entry->value;
        }
        entry = entry->next;
    }
    return 0; // Key not found, count is 0
}

void increment(HashMap *map, long long key) {
    unsigned int bucket_idx = hash(key);
    Entry *entry = map->buckets[bucket_idx];
    while (entry != NULL) {
        if (entry->key == key) {
            entry->value++;
            return;
        }
        entry = entry->next;
    }
    // Key not found, create new entry with value 1
    Entry *new_entry = (Entry *)malloc(sizeof(Entry));
    new_entry->key = key;
    new_entry->value = 1;
    new_entry->next = map->buckets[bucket_idx]; // Add to front of list
    map->buckets[bucket_idx] = new_entry;
}

void decrementAndRemove(HashMap *map, long long key) {
    unsigned int bucket_idx = hash(key);
    Entry *current = map->buckets[bucket_idx];
    Entry *prev = NULL;

    while (current != NULL) {
        if (current->key == key) {
            current->value--;
            if (current->value == 0) {
                // Remove entry
                if (prev == NULL) { // First entry in bucket
                    map->buckets[bucket_idx] = current->next;
                } else {
                    prev->next = current->next;
                }
                free(current);
            }
            return;
        }
        prev = current;
        current = current->next;
    }
    // Key not found (this case should ideally not happen if we only decrement existing keys)
}

int max(int a, int b) {
    return a > b ? a : b;
}

int waysToPartition(int* nums, int numsSize, int k) {
    // Calculate total sum of original array
    long long totalSum = 0;
    for (int i = 0; i < numsSize; ++i) {
        totalSum += nums[i];
    }

    int max_ways = 0;

    // Case 1: No element is changed
    // Check for partitions in the original array
    int initial_ways_count = 0;
    if (totalSum % 2 == 0) {
        long long target_sum_no_change = totalSum / 2;
        long long temp_prefix_sum = 0;
        // A partition requires at least one element in both left and right parts.
        // So, the partition point 'p' can range from 0 to numsSize - 2.
        for (int p = 0; p < numsSize - 1; ++p) {
            temp_prefix_sum += nums[p];
            if (temp_prefix_sum == target_sum_no_change) {
                initial_ways_count++;
            }
        }
    }
    max_ways = initial_ways_count;

    // Case 2: One element nums[i] is changed to k
    // We use two hash maps:
    // left_map: stores counts of prefix sums for elements before index i (original values)
    // right_map: stores counts of prefix sums for elements from index i onwards (original values)
    HashMap left_map;
    HashMap right_map;
    initHashMap(&left_map);
    initHashMap(&right_map);

    // Populate right_map with all original prefix sums
    long long current_prefix_sum_for_maps = 0;
    for (int j = 0; j < numsSize; ++j) {
        current_prefix_sum_for_maps += nums[j];
        increment(&right_map, current_prefix_sum_for_maps);
    }

    // Iterate `i` from `0` to `numsSize-1` (index of element to change)
    current_prefix_sum_for_maps = 0; // This will track `prefixSum[j]` for `j < i` (original values)
    for (int i = 0; i < numsSize; ++i) {
        long long old_val = nums[i];

        // The prefix sum up to index `i` (inclusive, using original values) is
        // `current_prefix_sum_for_maps + old_val`.
        // This sum `prefix_sum_at_i_original` is currently in `right_map`.
        // We decrement its count in `right_map` because conceptually, for the current iteration `i`,
        // it's being "moved" out of the `right_map` scope.
        // It will be added to `left_map` at the end of this iteration.
        long long prefix_sum_at_i_original = current_prefix_sum_for_maps + old_val;
        decrementAndRemove(&right_map, prefix_sum_at_i_original);

        // Calculate `newTotalSum` after changing `nums[i]` to `k`
        long long newTotalSum = totalSum - old_val + k;
        if (newTotalSum % 2 == 0) {
            long long targetSum = newTotalSum / 2;
            int current_ways = 0;

            // Count partitions where `p < i`
            // For `p < i`, the left partition sum `S_L_prime(p)` is simply `prefixSum[p]` (original values).
            // We need `prefixSum[p] == targetSum`.
            current_ways += get(&left_map, targetSum);

            // Count partitions where `p >= i`
            // For `p >= i`, the left partition sum `S_L_prime(p)` is `prefixSum[p] - old_val + k`.
            // (where `prefixSum[p]` is the original prefix sum up to `p`).
            // We need `prefixSum[p] - old_val + k == targetSum`.
            // This implies `prefixSum[p]` (original value) must be `targetSum + old_val - k`.
            long long target_sum_in_right_map = targetSum + old_val - k;
            current_ways += get(&right_map, target_sum_in_right_map);

            max_ways = max(max_ways, current_ways);
        }

        // After processing index `i`, its original prefix sum `prefix_sum_at_i_original`
        // is now considered part of the "left" side for future iterations (`j > i`).
        // So, we update `current_prefix_sum_for_maps` and add it to `left_map`.
        current_prefix_sum_for_maps += old_val; 
        increment(&left_map, current_prefix_sum_for_maps);
    }

    freeHashMap(&left_map);
    freeHashMap(&right_map);

    return max_ways;
}