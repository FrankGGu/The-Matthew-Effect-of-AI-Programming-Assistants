#include <stdlib.h> // For malloc, free, llabs
#include <stdbool.h> // For bool type

#define HASH_MAP_CAPACITY 200003 // A prime number larger than 2 * 10^5

typedef struct Node {
    long long key;   // bucket_id
    long long value; // nums[i]
    struct Node* next;
} Node;

typedef struct HashMap {
    Node** buckets;
} HashMap;

unsigned int hash(long long key) {
    // Using a large prime multiplier for better distribution
    return (unsigned int)((key * 2654435761ULL) % HASH_MAP_CAPACITY);
}

HashMap* createHashMap() {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    // calloc initializes all memory to zero, so bucket pointers are NULL
    map->buckets = (Node**)calloc(HASH_MAP_CAPACITY, sizeof(Node*));
    return map;
}

void hashMapPut(HashMap* map, long long key, long long value) {
    unsigned int bucket_idx = hash(key);
    Node* current = map->buckets[bucket_idx];

    // Check if key already exists (update value)
    while (current != NULL) {
        if (current->key == key) {
            current->value = value;
            return;
        }
        current = current->next;
    }

    // Key does not exist, insert new node at the beginning of the list
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->value = value;
    newNode->next = map->buckets[bucket_idx];
    map->buckets[bucket_idx] = newNode;
}

bool hashMapGet(HashMap* map, long long key, long long* out_value) {
    unsigned int bucket_idx = hash(key);
    Node* current = map->buckets[bucket_idx];
    while (current != NULL) {
        if (current->key == key) {
            *out_value = current->value;
            return true; // Found
        }
        current = current->next;
    }
    return false; // Not found
}

void hashMapRemove(HashMap* map, long long key) {
    unsigned int bucket_idx = hash(key);
    Node* current = map->buckets[bucket_idx];
    Node* prev = NULL;

    while (current != NULL) {
        if (current->key == key) {
            if (prev == NULL) { // Node to remove is the head of the list
                map->buckets[bucket_idx] = current->next;
            } else {
                prev->next = current->next;
            }
            free(current);
            return;
        }
        prev = current;
        current = current->next;
    }
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < HASH_MAP_CAPACITY; i++) {
        Node* current = map->buckets[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

long long getBucketId(long long val, long long bucketSize) {
    long long id = val / bucketSize;
    // C's integer division truncates towards zero.
    // For negative numbers, we need to adjust to get floor behavior.
    // E.g., -1 / 2 = 0 in C, but floor(-0.5) = -1.
    if (val < 0 && (val % bucketSize != 0)) {
        id--;
    }
    return id;
}

bool containsNearbyAlmostDuplicate(int* nums, int numsSize, int k, int t) {
    // Problem constraints: 0 <= k, 0 <= t. numsSize >= 2.
    // If k=0, abs(i-j) <= 0 implies i=j. But problem requires distinct indices.
    // So, if k=0, no distinct indices can satisfy abs(i-j) <= k.
    if (k == 0) {
        return false;
    }

    HashMap* map = createHashMap();
    // Use long long for bucketSize to prevent overflow if t is large (e.g., INT_MAX)
    long long bucketSize = (long long)t + 1;

    long long current_val_ll; // To store current nums[i] as long long
    long long map_val_ll;     // To store value retrieved from map as long long
    long long bucket_id;      // To store bucket ID

    for (int i = 0; i < numsSize; i++) {
        // Remove element that falls out of the sliding window [i-k, i]
        // The window contains elements nums[j] where i-k <= j <= i.
        // When processing nums[i], the element nums[i-k-1] (if it exists)
        // is now outside the window.
        if (i > k) {
            long long old_val_ll = nums[i - k - 1];
            long long old_bucket_id = getBucketId(old_val_ll, bucketSize);
            hashMapRemove(map, old_bucket_id);
        }

        current_val_ll = nums[i];
        bucket_id = getBucketId(current_val_ll, bucketSize);

        // Check current bucket:
        // If there's already a number in this bucket, their difference is guaranteed to be <= t
        // because the bucket size is t+1.
        if (hashMapGet(map, bucket_id, &map_val_ll)) {
            freeHashMap(map);
            return true;
        }

        // Check adjacent buckets:
        // Bucket (id - 1)
        if (hashMapGet(map, bucket_id - 1, &map_val_ll)) {
            if (llabs(current_val_ll - map_val_ll) <= t) {
                freeHashMap(map);
                return true;
            }
        }

        // Bucket (id + 1)
        if (hashMapGet(map, bucket_id + 1, &map_val_ll)) {
            if (llabs(current_val_ll - map_val_ll) <= t) {
                freeHashMap(map);
                return true;
            }
        }

        // Add current number to its bucket in the map
        hashMapPut(map, bucket_id, current_val_ll);
    }

    freeHashMap(map);
    return false;
}