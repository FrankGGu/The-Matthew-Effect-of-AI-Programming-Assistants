#include <stdlib.h> // For malloc, qsort

typedef struct {
    int val;
    int original_idx;
} Element;

int compareElements(const void *a, const void *b) {
    Element *elemA = (Element *)a;
    Element *elemB = (Element *)b;
    if (elemA->val != elemB->val) {
        return elemA->val - elemB->val;
    }
    // If values are equal, maintain original order (stable sort) or sort by index.
    // Sorting by index is not strictly necessary for correctness but can provide
    // a consistent order if multiple elements have the same value and index.
    return elemA->original_idx - elemB->original_idx;
}

long long* getDistances(int* arr, int arrSize, int* returnSize) {
    *returnSize = arrSize;
    long long* ans = (long long*)malloc(arrSize * sizeof(long long));
    if (ans == NULL) {
        return NULL; // Malloc failed
    }

    Element* elements = (Element*)malloc(arrSize * sizeof(Element));
    if (elements == NULL) {
        free(ans);
        return NULL; // Malloc failed
    }

    // Populate the elements array with values and their original indices
    for (int i = 0; i < arrSize; ++i) {
        elements[i].val = arr[i];
        elements[i].original_idx = i;
    }

    // Sort the elements array based on their values
    qsort(elements, arrSize, sizeof(Element), compareElements);

    int i = 0;
    while (i < arrSize) {
        int j = i;
        // Find all elements with the same value
        while (j < arrSize && elements[j].val == elements[i].val) {
            j++;
        }
        // Now, elements from index i to j-1 in the 'elements' array have the same value.
        // These are p_0, p_1, ..., p_{k-1} where k = j-i.

        int k = j - i; // Number of occurrences of the current value
        if (k == 1) {
            // If there's only one occurrence, the sum of distances is 0.
            ans[elements[i].original_idx] = 0;
            i = j; // Move to the next group
            continue;
        }

        // Calculate the total sum of original indices for this group
        long long total_sum_indices = 0;
        for (int m = i; m < j; ++m) {
            total_sum_indices += elements[m].original_idx;
        }

        long long current_prefix_sum = 0; // Sum of indices p_0 to p_{current_pos_in_group-1}
        for (int m = i; m < j; ++m) {
            int current_original_idx = elements[m].original_idx;
            int current_pos_in_group = m - i; // This is 'idx' in p_idx

            // Calculate sum of |p_idx - p_x| for x < idx:
            // (p_idx - p_0) + (p_idx - p_1) + ... + (p_idx - p_{idx-1})
            // = idx * p_idx - (p_0 + ... + p_{idx-1})
            long long left_sum = (long long)current_pos_in_group * current_original_idx - current_prefix_sum;

            // Update prefix sum to include current_original_idx for the next iteration
            current_prefix_sum += current_original_idx;

            // Calculate sum of |p_idx - p_x| for x > idx:
            // (p_{idx+1} - p_idx) + ... + (p_{k-1} - p_idx)
            // = (p_{idx+1} + ... + p_{k-1}) - (k - 1 - idx) * p_idx
            // (total_sum_indices - current_prefix_sum) gives (p_{idx+1} + ... + p_{k-1})
            long long right_sum = (total_sum_indices - current_prefix_sum) - (long long)(k - 1 - current_pos_in_group) * current_original_idx;

            ans[current_original_idx] = left_sum + right_sum;
        }
        i = j; // Move to the beginning of the next group
    }

    free(elements); // Free the temporary array
    return ans;
}