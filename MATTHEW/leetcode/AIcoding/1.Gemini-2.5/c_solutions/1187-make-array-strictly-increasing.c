#include <stdlib.h>
#include <limits.h> // For INT_MAX

int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* my_upper_bound(int* first, int* last, int val) {
    int* it;
    long count = last - first; // Use long for count to avoid overflow with large arrays
    long step;
    while (count > 0) {
        it = first;
        step = count / 2;
        it += step;
        if (val >= *it) {
            first = ++it;
            count -= step + 1;
        } else {
            count = step;
        }
    }
    return first;
}

int makeArrayIncreasing(int* arr1, int arr1Size, int* arr2, int arr2Size){
    // Sort arr2 and remove duplicates
    qsort(arr2, arr2Size, sizeof(int), compareInts);
    int uniqueArr2Size = 0;
    if (arr2Size > 0) {
        arr2[uniqueArr2Size++] = arr2[0];
        for (int i = 1; i < arr2Size; ++i) {
            if (arr2[i] != arr2[uniqueArr2Size - 1]) {
                arr2[uniqueArr2Size++] = arr2[i];
            }
        }
    }
    arr2Size = uniqueArr2Size; // Use the new size

    // dp_prev[k] = minimum last element value of a strictly increasing prefix using k replacements
    // Max replacements can be arr1Size
    int* dp_prev = (int*)malloc((arr1Size + 1) * sizeof(int));
    // Initialize dp_prev with a large value (infinity)
    for (int i = 0; i <= arr1Size; ++i) {
        dp_prev[i] = INT_MAX;
    }
    dp_prev[0] = -1; // Sentinel: a value smaller than any possible array element

    for (int i = 0; i < arr1Size; ++i) {
        int* dp_curr = (int*)malloc((arr1Size + 1) * sizeof(int));
        for (int j = 0; j <= arr1Size; ++j) {
            dp_curr[j] = INT_MAX;
        }

        // k is the number of replacements for the prefix arr1[0...i]
        for (int k = 0; k <= i + 1; ++k) {
            // Option 1: Don't replace arr1[i]
            // This means we used k replacements for arr1[0...i-1] AND arr1[i] is greater than dp_prev[k]
            if (dp_prev[k] != INT_MAX && arr1[i] > dp_prev[k]) {
                if (arr1[i] < dp_curr[k]) {
                    dp_curr[k] = arr1[i];
                }
            }

            // Option 2: Replace arr1[i]
            // This means we used k-1 replacements for arr1[0...i-1] AND we replace arr1[i]
            if (k > 0 && dp_prev[k-1] != INT_MAX) {
                // Find the smallest element in arr2 that is greater than dp_prev[k-1]
                int* it = my_upper_bound(arr2, arr2 + arr2Size, dp_prev[k-1]);
                if (it != arr2 + arr2Size) { // If such an element exists
                    if (*it < dp_curr[k]) {
                        dp_curr[k] = *it;
                    }
                }
            }
        }
        free(dp_prev);
        dp_prev = dp_curr;
    }

    // Find the minimum k for which dp_prev[k] is reachable (not INT_MAX)
    for (int k = 0; k <= arr1Size; ++k) {
        if (dp_prev[k] != INT_MAX) {
            free(dp_prev);
            return k;
        }
    }

    free(dp_prev);
    return -1; // No solution found
}