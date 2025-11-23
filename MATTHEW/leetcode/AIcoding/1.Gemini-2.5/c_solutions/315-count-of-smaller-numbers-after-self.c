#include <stdlib.h> // For malloc, calloc, free

struct Element {
    int val;
    int index;
};

void merge(struct Element* arr, int low, int mid, int high, int* ans, struct Element* temp) {
    int i = low;       // Pointer for the left subarray
    int j = mid + 1;   // Pointer for the right subarray
    int k = low;       // Pointer for the temporary array
    int right_elements_processed = 0; // Counts elements from the right subarray that are smaller than current left element

    // Merge the two sorted halves into temp array
    while (i <= mid && j <= high) {
        if (arr[i].val <= arr[j].val) {
            // If element from left half is smaller or equal,
            // it means all 'right_elements_processed' elements from the right half
            // that were smaller than arr[i] have already been counted and moved.
            ans[arr[i].index] += right_elements_processed;
            temp[k++] = arr[i++];
        } else {
            // If element from right half is smaller,
            // it means it's smaller than arr[i] and all subsequent elements in the left half arr[i...mid].
            // This element arr[j] will contribute to the count for arr[i] and others in the left half.
            temp[k++] = arr[j++];
            right_elements_processed++;
        }
    }

    // Copy any remaining elements from the left half
    while (i <= mid) {
        ans[arr[i].index] += right_elements_processed;
        temp[k++] = arr[i++];
    }

    // Copy any remaining elements from the right half (no contribution to counts here)
    while (j <= high) {
        temp[k++] = arr[j++];
    }

    // Copy sorted elements from temp back to arr
    for (int x = low; x <= high; x++) {
        arr[x] = temp[x];
    }
}

void mergeSort(struct Element* arr, int low, int high, int* ans, struct Element* temp) {
    if (low >= high) {
        return;
    }

    int mid = low + (high - low) / 2;
    mergeSort(arr, low, mid, ans, temp);
    mergeSort(arr, mid + 1, high, ans, temp);
    merge(arr, low, mid, high, ans, temp);
}

int* countSmaller(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    if (numsSize == 0) {
        return NULL;
    }

    // Allocate memory for the result array, initialized to zeros
    int* ans = (int*) calloc(numsSize, sizeof(int));
    if (ans == NULL) {
        return NULL; // Handle allocation failure
    }

    // Create an array of Element structs to store values and original indices
    struct Element* elements = (struct Element*) malloc(numsSize * sizeof(struct Element));
    if (elements == NULL) {
        free(ans);
        return NULL; // Handle allocation failure
    }

    // Create a temporary array for merge sort
    struct Element* temp = (struct Element*) malloc(numsSize * sizeof(struct Element));
    if (temp == NULL) {
        free(ans);
        free(elements);
        return NULL; // Handle allocation failure
    }

    // Populate the elements array
    for (int i = 0; i < numsSize; i++) {
        elements[i].val = nums[i];
        elements[i].index = i;
    }

    // Perform merge sort to count smaller numbers
    mergeSort(elements, 0, numsSize - 1, ans, temp);

    // Free allocated memory
    free(elements);
    free(temp);

    return ans;
}