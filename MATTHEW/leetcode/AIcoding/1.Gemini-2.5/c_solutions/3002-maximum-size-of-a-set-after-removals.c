#include <stdlib.h> // For malloc, realloc, free

typedef struct {
    int* data;
    int size;
    int capacity;
} IntVector;

void initIntVector(IntVector* vec) {
    vec->data = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

void pushBackIntVector(IntVector* vec, int val) {
    if (vec->size == vec->capacity) {
        int newCapacity = (vec->capacity == 0) ? 4 : vec->capacity * 2;
        int* newData = (int*)realloc(vec->data, newCapacity * sizeof(int));
        if (newData == NULL) {
            exit(EXIT_FAILURE); // Memory allocation failed
        }
        vec->data = newData;
        vec->capacity = newCapacity;
    }
    vec->data[vec->size++] = val;
}

void freeIntVector(IntVector* vec) {
    free(vec->data);
    vec->data = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int longestEqualSubarray(int* nums, int numsSize, int k) {
    // Array of IntVector structs to store indices for each number.
    // nums[i] values are 1-indexed, up to numsSize. So we need size numsSize + 1.
    IntVector* indices = (IntVector*)malloc((numsSize + 1) * sizeof(IntVector));
    if (indices == NULL) {
        exit(EXIT_FAILURE); // Memory allocation failed
    }

    // Initialize each IntVector in the array
    for (int i = 0; i <= numsSize; ++i) {
        initIntVector(&indices[i]);
    }

    // Populate the indices for each number
    for (int i = 0; i < numsSize; ++i) {
        pushBackIntVector(&indices[nums[i]], i);
    }

    int max_len = 0;

    // Iterate through each unique number's indices
    for (int val = 1; val <= numsSize; ++val) {
        IntVector* current_indices = &indices[val];
        if (current_indices->size == 0) {
            continue; // No occurrences of this number
        }

        int left = 0; // Left pointer for the sliding window on current_indices
        for (int right = 0; right < current_indices->size; ++right) {
            int current_length = right - left + 1;
            // Calculate the total number of elements in the original array within the window
            // defined by current_indices[left] and current_indices[right]
            int elements_in_original_window = current_indices->data[right] - current_indices->data[left] + 1;
            // The number of elements that are NOT 'val' within this window, which need to be deleted
            int elements_to_delete = elements_in_original_window - current_length;

            // Shrink the window from the left if too many elements need to be deleted
            while (elements_to_delete > k) {
                left++;
                current_length = right - left + 1; // Recalculate current_length
                // If left pointer moves past right, it means no valid window can be formed with current right.
                // This check is implicitly handled by the loop conditions and elements_to_delete logic.
                // If left == right, elements_to_delete becomes 0, and the while loop terminates (as k >= 0).
                if (left > right) {
                    break; 
                }
                elements_in_original_window = current_indices->data[right] - current_indices->data[left] + 1;
                elements_to_delete = elements_in_original_window - current_length;
            }

            // After the while loop, the window [left, right] is valid (elements_to_delete <= k)
            // Update max_len with the current valid window's length
            max_len = max(max_len, current_length);
        }
    }

    // Free all allocated memory for IntVectors
    for (int i = 0; i <= numsSize; ++i) {
        freeIntVector(&indices[i]);
    }
    free(indices); // Free the array of IntVector structs itself

    return max_len;
}