#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char*** g_result;
int* g_returnColumnSizes;
int g_resultSize;
int g_resultCapacity;

char* g_currentPartition[16]; // Max 16 substrings for s.length <= 16
int g_currentPartitionSize;

bool isPalindrome(char* s, int start, int end) {
    while (start < end) {
        if (s[start] != s[end]) {
            return false;
        }
        start++;
        end--;
    }
    return true;
}

void backtrack(char* s, int start, int n) {
    if (start == n) {
        // Base case: A valid partition is found
        // Store the current partition into g_result
        if (g_resultSize == g_resultCapacity) {
            g_resultCapacity *= 2;
            g_result = (char***)realloc(g_result, g_resultCapacity * sizeof(char**));
            g_returnColumnSizes = (int*)realloc(g_returnColumnSizes, g_resultCapacity * sizeof(int));
        }

        g_result[g_resultSize] = (char**)malloc(g_currentPartitionSize * sizeof(char*));
        g_returnColumnSizes[g_resultSize] = g_currentPartitionSize;

        for (int i = 0; i < g_currentPartitionSize; i++) {
            g_result[g_resultSize][i] = (char*)malloc((strlen(g_currentPartition[i]) + 1) * sizeof(char));
            strcpy(g_result[g_resultSize][i], g_currentPartition[i]);
        }
        g_resultSize++;
        return;
    }

    // Recursive step
    for (int i = start; i < n; i++) {
        if (isPalindrome(s, start, i)) {
            // If s[start...i] is a palindrome
            // Create the substring
            int len = i - start + 1;
            char* sub = (char*)malloc((len + 1) * sizeof(char));
            strncpy(sub, s + start, len);
            sub[len] = '\0';

            // Add to current partition
            g_currentPartition[g_currentPartitionSize++] = sub;

            // Recurse
            backtrack(s, i + 1, n);

            // Backtrack: remove the last added substring
            g_currentPartitionSize--;
            free(sub); // Free the memory allocated for the substring
        }
    }
}

char*** partition(char* s, int* returnSize, int** returnColumnSizes) {
    int n = strlen(s);

    // Initialize global variables
    g_resultSize = 0;
    g_resultCapacity = 16; // Initial capacity, will grow as needed
    g_result = (char***)malloc(g_resultCapacity * sizeof(char**));
    g_returnColumnSizes = (int*)malloc(g_resultCapacity * sizeof(int));
    g_currentPartitionSize = 0;

    backtrack(s, 0, n);

    *returnSize = g_resultSize;

    // Reallocate g_result and g_returnColumnSizes to the exact size
    g_result = (char***)realloc(g_result, g_resultSize * sizeof(char**));
    g_returnColumnSizes = (int*)realloc(g_returnColumnSizes, g_resultSize * sizeof(int));
    *returnColumnSizes = g_returnColumnSizes;

    return g_result;
}