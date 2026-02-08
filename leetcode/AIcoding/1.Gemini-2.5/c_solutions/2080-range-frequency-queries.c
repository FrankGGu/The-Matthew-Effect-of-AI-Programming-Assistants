#include <stdlib.h> // For malloc, free, realloc

typedef struct {
    int* data;
    int size;
    int capacity;
} IntVector;

static void intVectorInit(IntVector* vec) {
    vec->data = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

static void intVectorPushBack(IntVector* vec, int val) {
    if (vec->size == vec->capacity) {
        int new_capacity = (vec->capacity == 0) ? 1 : vec->capacity * 2;
        int* new_data = (int*)realloc(vec->data, new_capacity * sizeof(int));
        vec->data = new_data; // Assuming realloc always succeeds in LeetCode environment
        vec->capacity = new_capacity;
    }
    vec->data[vec->size++] = val;
}

static void intVectorFree(IntVector* vec) {
    free(vec->data);
    vec->data = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

typedef struct {
    IntVector* value_indices; // Array of IntVector, one for each possible value
    int max_value;            // Maximum possible value in the input array arr
} RangeFreqQuery;

static int* lower_bound(int* arr, int size, int target) {
    int low = 0, high = size; // high is exclusive
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] < target) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return arr + low;
}

static int* upper_bound(int* arr, int size, int target) {
    int low = 0, high = size; // high is exclusive
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] <= target) { // Note the <= here
            low = mid + 1;
        } else {
            high = mid;
        }
    }
    return arr + low;
}

RangeFreqQuery* rangeFreqQueryCreate(int* arr, int arrSize) {
    RangeFreqQuery* obj = (RangeFreqQuery*)malloc(sizeof(RangeFreqQuery));

    // Max value constraint for arr[i] and value is 10^5.
    // We use 1-based indexing for values, so array size is max_value + 1.
    obj->max_value = 100000; 
    obj->value_indices = (IntVector*)malloc((obj->max_value + 1) * sizeof(IntVector));

    // Initialize all IntVectors
    for (int i = 0; i <= obj->max_value; ++i) {
        intVectorInit(&obj->value_indices[i]);
    }

    // Populate the IntVectors with indices
    for (int i = 0; i < arrSize; ++i) {
        int val = arr[i];
        // Ensure value is within expected range (1 to max_value)
        if (val >= 1 && val <= obj->max_value) { 
            intVectorPushBack(&obj->value_indices[val], i);
        }
    }

    return obj;
}

int rangeFreqQueryQuery(RangeFreqQuery* obj, int left, int right, int value) {
    // If the queried value is outside the possible range, it cannot exist.
    if (value < 1 || value > obj->max_value) {
        return 0;
    }

    IntVector* vec = &obj->value_indices[value];

    // If the value does not appear in the array at all, its index list will be empty.
    if (vec->size == 0) {
        return 0;
    }

    // Find the first index in 'vec->data' that is greater than or equal to 'left'.
    int* it_low = lower_bound(vec->data, vec->size, left);

    // Find the first index in 'vec->data' that is strictly greater than 'right'.
    int* it_high = upper_bound(vec->data, vec->size, right);

    // The count of elements within the range [left, right] is the difference
    // between the two pointers.
    return (int)(it_high - it_low);
}

void rangeFreqQueryFree(RangeFreqQuery* obj) {
    if (obj == NULL) return;

    if (obj->value_indices != NULL) {
        // Free each individual IntVector's data array
        for (int i = 0; i <= obj->max_value; ++i) {
            intVectorFree(&obj->value_indices[i]);
        }
        // Free the array of IntVectors itself
        free(obj->value_indices);
    }
    // Free the RangeFreqQuery object
    free(obj);
}