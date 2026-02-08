#include <stdlib.h>

static void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int* prevPermOpt1(int* arr, int arrSize, int* returnSize) {
    *returnSize = arrSize;

    // As per constraints, arrSize >= 1.
    // If arrSize is 1, no swap is possible.
    if (arrSize <= 1) {
        return arr;
    }

    // Iterate from right to left, finding the rightmost element arr[i]
    // that can be swapped to form a smaller permutation.
    // This means arr[i] must be greater than some element arr[j] to its right (j > i).
    for (int i = arrSize - 2; i >= 0; i--) {
        int best_j = -1;
        int best_val_for_swap = -1; // Stores the largest value arr[j] found so far that is less than arr[i]

        // For the current arr[i], find the best arr[j] to swap with.
        // We need the largest arr[j] (where j > i and arr[j] < arr[i]).
        // If multiple such arr[j] exist with the same largest value,
        // choose the one with the smallest index j (leftmost).
        // Iterating j from i+1 to arrSize-1 naturally finds the leftmost such j
        // if we only update when arr[j] is strictly greater than best_val_for_swap.
        for (int j = i + 1; j < arrSize; j++) {
            if (arr[j] < arr[i]) {
                if (arr[j] > best_val_for_swap) {
                    best_val_for_swap = arr[j];
                    best_j = j;
                }
                // If arr[j] == best_val_for_swap, we do nothing.
                // This is because 'j' is increasing, so 'best_j' would already hold
                // the smallest index for this 'best_val_for_swap'.
            }
        }

        // If a suitable best_j was found for this i, perform the swap and return.
        // Since we iterate i from right to left, the first i for which we find a best_j
        // will result in the lexicographically largest smaller permutation.
        if (best_j != -1) {
            swap(&arr[i], &arr[best_j]);
            return arr;
        }
    }

    // If the loop finishes, it means no such swap is possible (e.g., array is sorted in ascending order).
    // In this case, return the original array as per problem statement.
    return arr;
}