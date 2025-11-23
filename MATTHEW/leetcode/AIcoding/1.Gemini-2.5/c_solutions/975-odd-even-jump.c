#include <stdlib.h>
#include <stdbool.h>

void find_next_indices(int* arr, int n, int* next_arr, bool is_greater) {
    // Stack to store indices
    int* stack = (int*)malloc(n * sizeof(int));
    int top = -1; // Stack pointer

    // Initialize next_arr with -1 (or some sentinel indicating no next element)
    for (int i = 0; i < n; ++i) {
        next_arr[i] = -1;
    }

    // Iterate from right to left
    for (int i = n - 1; i >= 0; --i) {
        // Pop elements from stack that do not satisfy the condition
        // For next_greater_equal: pop if arr[stack[top]] < arr[i]
        // For next_smaller_equal: pop if arr[stack[top]] > arr[i]
        while (top != -1 && ((is_greater && arr[stack[top]] < arr[i]) || (!is_greater && arr[stack[top]] > arr[i]))) {
            top--;
        }

        // If stack is not empty, stack[top] is the next element that satisfies the condition
        if (top != -1) {
            next_arr[i] = stack[top];
        }

        // Push current index onto stack
        stack[++top] = i;
    }

    free(stack);
}

int oddEvenJumps(int* arr, int arrSize) {
    if (arrSize <= 1) {
        return arrSize;
    }

    // dp_odd[i]: can we reach the end starting from i with an odd-numbered jump as the first jump from i?
    // dp_even[i]: can we reach the end starting from i with an even-numbered jump as the first jump from i?
    bool* dp_odd = (bool*)calloc(arrSize, sizeof(bool));
    bool* dp_even = (bool*)calloc(arrSize, sizeof(bool));

    // next_greater_equal[i]: smallest index j > i such that arr[j] >= arr[i]
    // next_smaller_equal[i]: smallest index j > i such that arr[j] <= arr[i]
    int* next_greater_equal = (int*)malloc(arrSize * sizeof(int));
    int* next_smaller_equal = (int*)malloc(arrSize * sizeof(int));

    // Populate next_greater_equal and next_smaller_equal arrays
    find_next_indices(arr, arrSize, next_greater_equal, true);  // true for greater or equal
    find_next_indices(arr, arrSize, next_smaller_equal, false); // false for smaller or equal

    // Base cases: The last element is always a good starting point to reach itself
    dp_odd[arrSize - 1] = true;
    dp_even[arrSize - 1] = true;

    int good_starting_indices = 1; // arrSize - 1 is always a good starting index

    // Iterate from right to left
    for (int i = arrSize - 2; i >= 0; --i) {
        // For an odd jump from i, we need to find next_greater_equal[i]
        // If we can make an odd jump to index j, the next jump from j will be an even jump
        if (next_greater_equal[i] != -1) {
            dp_odd[i] = dp_even[next_greater_equal[i]];
        }

        // For an even jump from i, we need to find next_smaller_equal[i]
        // If we can make an even jump to index j, the next jump from j will be an odd jump
        if (next_smaller_equal[i] != -1) {
            dp_even[i] = dp_odd[next_smaller_equal[i]];
        }

        // If an odd jump from i can lead to the end, then i is a good starting index
        if (dp_odd[i]) {
            good_starting_indices++;
        }
    }

    // Free allocated memory
    free(dp_odd);
    free(dp_even);
    free(next_greater_equal);
    free(next_smaller_equal);

    return good_starting_indices;
}