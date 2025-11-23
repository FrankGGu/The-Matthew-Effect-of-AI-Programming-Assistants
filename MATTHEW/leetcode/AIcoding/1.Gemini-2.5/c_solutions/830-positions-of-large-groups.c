#include <stdlib.h>
#include <string.h>

int** largeGroupPositions(char * s, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;

    int capacity = 10; // Initial capacity for the result array of pointers
    int** result = (int**) malloc(capacity * sizeof(int*));

    int n = strlen(s);
    if (n == 0) {
        free(result); // Free the initial malloc if the string is empty
        *returnColumnSizes = NULL;
        return NULL;
    }

    int i = 0;
    while (i < n) {
        int j = i;
        // Find the end of the current group of identical characters
        while (j < n && s[j] == s[i]) {
            j++;
        }

        // The current group is s[i...j-1]
        int length = j - i;

        if (length >= 3) {
            // This is a large group, add its start and end positions to the result
            if (*returnSize == capacity) {
                // Double the capacity if needed
                capacity *= 2;
                result = (int**) realloc(result, capacity * sizeof(int*));
            }

            result[*returnSize] = (int*) malloc(2 * sizeof(int));
            result[*returnSize][0] = i;
            result[*returnSize][1] = j - 1;
            (*returnSize)++;
        }

        i = j; // Move to the start of the next potential group
    }

    // Allocate and populate returnColumnSizes array
    if (*returnSize > 0) {
        *returnColumnSizes = (int*) malloc(*returnSize * sizeof(int));
        for (int k = 0; k < *returnSize; k++) {
            (*returnColumnSizes)[k] = 2; // Each large group has 2 positions (start, end)
        }
    } else {
        // If no large groups were found, *returnSize is 0.
        // *returnColumnSizes should be NULL in this case.
        *returnColumnSizes = NULL;
        // The 'result' array was initially allocated but no elements were added.
        // It's typically returned as is, and the LeetCode platform handles freeing it.
    }

    return result;
}