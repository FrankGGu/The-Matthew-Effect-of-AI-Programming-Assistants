#include <stdlib.h> // For malloc, realloc, free
#include <string.h> // For calloc (which initializes memory to zero)

typedef struct {
    int* arr;
    int top;
    int capacity;
} Stack;

void stack_init(Stack* s, int capacity) {
    s->arr = (int*)malloc(sizeof(int) * capacity);
    s->top = -1;
    s->capacity = capacity;
}

void stack_push(Stack* s, int val) {
    // Assuming capacity is sufficient as per problem constraints (N <= 10^5)
    s->arr[++(s->top)] = val;
}

int stack_peek(Stack* s) {
    return s->arr[s->top];
}

void stack_pop(Stack* s) {
    (s->top)--;
}

int stack_is_empty(Stack* s) {
    return s->top == -1;
}

void stack_free(Stack* s) {
    free(s->arr);
}

typedef struct {
    int* arr;
    int size;
    int capacity;
} IntVector;

void int_vector_init(IntVector* v) {
    v->size = 0;
    v->capacity = 4; // Initial capacity
    v->arr = (int*)malloc(sizeof(int) * v->capacity);
}

void int_vector_push_back(IntVector* v, int val) {
    if (v->size == v->capacity) {
        v->capacity *= 2;
        v->arr = (int*)realloc(v->arr, sizeof(int) * v->capacity);
    }
    v->arr[v->size++] = val;
}

void int_vector_free(IntVector* v) {
    free(v->arr);
}

#define HASH_MAP_INITIAL_CAPACITY 100003 // A prime number, larger than max N (10^5)

typedef struct {
    int key;
    IntVector* value; // Pointer to a dynamically allocated IntVector
    int occupied; // 0 if empty, 1 if occupied
} HashMapEntry;

typedef struct {
    HashMapEntry* entries;
    int size; // Number of occupied entries
    int capacity; // Total capacity of the hash table array
} HashMap;

unsigned int hash_int(int key) {
    return (unsigned int)key % HASH_MAP_INITIAL_CAPACITY;
}

void hash_map_init(HashMap* hm) {
    hm->entries = (HashMapEntry*)calloc(HASH_MAP_INITIAL_CAPACITY, sizeof(HashMapEntry)); // calloc initializes to zero
    hm->size = 0;
    hm->capacity = HASH_MAP_INITIAL_CAPACITY;
}

IntVector* hash_map_get_or_create(HashMap* hm, int key) {
    unsigned int index = hash_int(key);
    while (hm->entries[index].occupied) {
        if (hm->entries[index].key == key) {
            return hm->entries[index].value;
        }
        index = (index + 1) % hm->capacity; // Linear probing
    }
    // Key not found, create new entry
    hm->entries[index].key = key;
    hm->entries[index].value = (IntVector*)malloc(sizeof(IntVector));
    int_vector_init(hm->entries[index].value);
    hm->entries[index].occupied = 1;
    hm->size++;
    return hm->entries[index].value;
}

void hash_map_free(HashMap* hm) {
    for (int i = 0; i < hm->capacity; ++i) {
        if (hm->entries[i].occupied) {
            int_vector_free(hm->entries[i].value);
            free(hm->entries[i].value);
        }
    }
    free(hm->entries);
}

int* upper_bound_custom(int* arr, int size, int val) {
    int low = 0, high = size; // Search range [low, high)
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] <= val) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return arr + low;
}

long long countSubarrays(int* nums, int numsSize) {
    // 1. Compute prev_greater array using a monotonic stack.
    // prev_greater[i] stores the index of the nearest element to the left of i
    // that is strictly greater than nums[i].
    int* prev_greater = (int*)malloc(sizeof(int) * numsSize);
    Stack st;
    stack_init(&st, numsSize);

    for (int i = 0; i < numsSize; ++i) {
        // Pop elements from stack that are less than or equal to current element
        // because they cannot be 'strictly greater' to the left of future elements.
        while (!stack_is_empty(&st) && nums[stack_peek(&st)] <= nums[i]) {
            stack_pop(&st);
        }
        prev_greater[i] = stack_is_empty(&st) ? -1 : stack_peek(&st);
        stack_push(&st, i);
    }
    stack_free(&st);

    // 2. Create a hash map to store indices for each number.
    // This maps value -> list of indices where this value appears.
    HashMap val_indices_map;
    hash_map_init(&val_indices_map);

    for (int i = 0; i < numsSize; ++i) {
        IntVector* current_vec = hash_map_get_or_create(&val_indices_map, nums[i]);
        int_vector_push_back(current_vec, i);
    }

    // 3. Iterate 'r' from 0 to numsSize-1 and calculate the total count.
    long long ans = 0;
    for (int r = 0; r < numsSize; ++r) {
        int target_val = nums[r];
        int lower_bound_for_l = prev_greater[r]; // 'l' must be > this index

        // Retrieve the list of indices for target_val.
        // All nums[r] values are guaranteed to be in the map from step 2.
        IntVector* indices_list_ptr = hash_map_get_or_create(&val_indices_map, target_val);

        // Count elements 'l' in indices_list_ptr->arr such that lower_bound_for_l < l <= r.
        // This is done using two calls to upper_bound_custom.
        // it_start points to the first index > lower_bound_for_l.
        // it_end points to the first index > r.
        // The difference (it_end - it_start) gives the count of indices 'l' in the range (lower_bound_for_l, r].
        int* it_start = upper_bound_custom(indices_list_ptr->arr, indices_list_ptr->size, lower_bound_for_l);
        int* it_end = upper_bound_custom(indices_list_ptr->arr, indices_list_ptr->size, r);

        ans += (it_end - it_start);
    }

    // Cleanup allocated memory
    free(prev_greater);
    hash_map_free(&val_indices_map);

    return ans;
}