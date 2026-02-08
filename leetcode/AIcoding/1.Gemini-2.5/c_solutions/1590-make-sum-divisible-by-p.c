#include <stdlib.h>
#include <limits.h>

typedef struct Node {
    int key;    // remainder
    int value;  // index
    struct Node* next;
} Node;

typedef struct {
    Node** buckets;
    int size; // number of buckets
} HashMap;

int hash(int key, int size) {
    return key % size;
}

HashMap* createHashMap(int size) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->size = size;
    map->buckets = (Node**)calloc(size, sizeof(Node*)); // calloc initializes pointers to NULL
    return map;
}

void hashMapPut(HashMap* map, int key, int value) {
    int bucketIndex = hash(key, map->size);
    Node* current = map->buckets[bucketIndex];

    // Traverse the list to find if the key already exists
    while (current != NULL) {
        if (current->key == key) {
            current->value = value; // Key found, update its value
            return;
        }
        current = current->next;
    }

    // Key not found, create a new node and add it to the beginning of the bucket's list
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->value = value;
    newNode->next = map->buckets[bucketIndex]; // Link new node to the head of the list
    map->buckets[bucketIndex] = newNode;       // Update bucket head to new node
}

int* hashMapGet(HashMap* map, int key) {
    int bucketIndex = hash(key, map->size);
    Node* current = map->buckets[bucketIndex];

    // Traverse the list to find the key
    while (current != NULL) {
        if (current->key == key) {
            return &(current->value); // Key found, return pointer to its value
        }
        current = current->next;
    }
    return NULL; // Key not found
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->size; i++) {
        Node* current = map->buckets[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp); // Free individual nodes
        }
    }
    free(map->buckets); // Free the array of buckets
    free(map);          // Free the HashMap structure itself
}

int minSubarrayRemovals(int* nums, int numsSize, int p) {
    long long totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    int target_remainder = totalSum % p;

    // If the total sum is already divisible by p, no removal is needed.
    if (target_remainder == 0) {
        return 0;
    }

    // Initialize min_len to numsSize. This will be the result if no valid subarray
    // (other than the entire array) is found.
    int min_len = numsSize;

    // A prime number for hash map size helps distribute keys evenly, reducing collisions.
    // 200003 is a prime number larger than 2 * 10^5 (max numsSize).
    HashMap* map = createHashMap(200003); 

    long long current_prefix_sum_val = 0; // Stores the actual prefix sum to avoid overflow before modulo

    // Initialize the hash map with a prefix sum of 0 at index -1.
    // This handles cases where the required subarray starts from index 0.
    hashMapPut(map, 0, -1); 

    for (int i = 0; i < numsSize; i++) {
        current_prefix_sum_val += nums[i];
        int current_prefix_sum_mod_p = current_prefix_sum_val % p;

        // We are looking for a previous prefix sum `prev_sum_mod_p` such that:
        // (current_prefix_sum_mod_p - prev_sum_mod_p + p) % p == target_remainder
        // Rearranging: prev_sum_mod_p == (current_prefix_sum_mod_p - target_remainder + p) % p
        int desired_previous_rem = (current_prefix_sum_mod_p - target_remainder + p) % p;

        int* prev_index_ptr = hashMapGet(map, desired_previous_rem);
        if (prev_index_ptr != NULL) {
            // If desired_previous_rem is found, it means a subarray from (*prev_index_ptr) + 1 to i
            // has a sum modulo p equal to target_remainder.
            // The length of this subarray is i - (*prev_index_ptr).
            int current_subarray_len = i - *prev_index_ptr;
            if (current_subarray_len < min_len) {
                min_len = current_subarray_len;
            }
        }

        // Store the current prefix sum modulo p and its index.
        // If the remainder already exists, update its index to the current one.
        // This ensures we always have the latest (rightmost) occurrence of a remainder,
        // which helps in finding the shortest subarray.
        hashMapPut(map, current_prefix_sum_mod_p, i);
    }

    freeHashMap(map);

    // If min_len is still equal to numsSize, it means no subarray (other than the entire array itself)
    // was found that satisfies the condition. Removing the entire array is usually not considered a valid solution
    // for "minimum length subarray to remove". Thus, return -1.
    if (min_len == numsSize) {
        return -1;
    }
    return min_len;
}