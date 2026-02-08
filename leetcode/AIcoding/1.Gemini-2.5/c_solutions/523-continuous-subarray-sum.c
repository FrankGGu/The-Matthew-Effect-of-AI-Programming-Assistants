#include <stdbool.h>
#include <stdlib.h>

typedef struct LLEntry {
    long long key;
    int value;
    struct LLEntry* next;
} LLEntry;

typedef struct {
    int capacity;
    LLEntry** buckets;
} LLHashMap;

unsigned int ll_hash(long long key, int capacity) {
    // Ensure the result of modulo is non-negative
    // C's % operator can yield negative results for negative operands.
    // (key % capacity + capacity) % capacity ensures a positive result in [0, capacity-1]
    return (unsigned int)(((key % capacity) + capacity) % capacity);
}

LLHashMap* createLLHashMap(int capacity) {
    LLHashMap* map = (LLHashMap*)malloc(sizeof(LLHashMap));
    map->capacity = capacity;
    // calloc initializes memory to zero (NULL for pointers)
    map->buckets = (LLEntry**)calloc(capacity, sizeof(LLEntry*));
    return map;
}

void ll_put(LLHashMap* map, long long key, int value) {
    unsigned int bucketIndex = ll_hash(key, map->capacity);
    LLEntry* current = map->buckets[bucketIndex];

    // Check if key already exists, if so, update value
    while (current != NULL) {
        if (current->key == key) {
            current->value = value;
            return;
        }
        current = current->next;
    }

    // Key not found, create new entry and add to the front of the list
    LLEntry* newEntry = (LLEntry*)malloc(sizeof(LLEntry));
    newEntry->key = key;
    newEntry->value = value;
    newEntry->next = map->buckets[bucketIndex];
    map->buckets[bucketIndex] = newEntry;
}

bool ll_get(LLHashMap* map, long long key, int* out_value) {
    unsigned int bucketIndex = ll_hash(key, map->capacity);
    LLEntry* current = map->buckets[bucketIndex];

    while (current != NULL) {
        if (current->key == key) {
            *out_value = current->value;
            return true;
        }
        current = current->next;
    }
    return false; // Key not found
}

void freeLLHashMap(LLHashMap* map) {
    if (map == NULL) return;
    for (int i = 0; i < map->capacity; ++i) {
        LLEntry* current = map->buckets[i];
        while (current != NULL) {
            LLEntry* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

bool checkSubarraySum(int* nums, int numsSize, int k) {
    // A prime number for hash map capacity, larger than max numsSize (10^5)
    // to reduce collisions. 200003 is a prime number.
    LLHashMap* map = createLLHashMap(200003); 

    long long current_sum = 0;
    int previous_index;

    // Initialize map with (0, -1) to handle cases where the subarray itself
    // (starting from index 0) sums to a multiple of k.
    // The -1 index signifies a "prefix sum" before any elements are processed.
    ll_put(map, 0, -1);

    for (int i = 0; i < numsSize; ++i) {
        current_sum += nums[i];

        long long remainder;
        if (k == 0) {
            // If k is 0, we are looking for a subarray sum that is 0.
            // So the 'remainder' is the current_sum itself.
            remainder = current_sum;
        } else {
            // For k != 0, we care about the remainder when divided by k.
            remainder = current_sum % k;
            // Ensure remainder is non-negative (C's % can return negative for negative dividends)
            if (remainder < 0) {
                remainder += k;
            }
        }

        // Check if this remainder has been seen before
        if (ll_get(map, remainder, &previous_index)) {
            // If the current index `i` and the stored `previous_index`
            // are such that `i - previous_index >= 2`, it means we found
            // a continuous subarray of size at least two whose sum is a multiple of k.
            // The subarray is nums[previous_index + 1 ... i].
            // Its length is i - (previous_index + 1) + 1 = i - previous_index.
            if (i - previous_index >= 2) {
                freeLLHashMap(map);
                return true;
            }
        } else {
            // If this remainder is new, store its first occurrence index
            ll_put(map, remainder, i);
        }
    }

    freeLLHashMap(map);
    return false;
}