#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

static bool isPalindrome(char *s, int start, int end) {
    while (start < end) {
        if (s[start] != s[end]) {
            return false;
        }
        start++;
        end--;
    }
    return true;
}

static char ***g_result;
static int *g_resultColSizes;
static int g_resultSize;
static int g_resultCapacity;

static char **g_currentPartition;
static int g_currentPartitionSize;
static int g_currentPartitionCapacity;

static void resizeCurrentPartition() {
    if (g_currentPartitionSize == g_currentPartitionCapacity) {
        g_currentPartitionCapacity = g_currentPartitionCapacity == 0 ? 2 : g_currentPartitionCapacity * 2;
        g_currentPartition = (char **)realloc(g_currentPartition, sizeof(char *) * g_currentPartitionCapacity);
    }
}

static void resizeResult() {
    if (g_resultSize == g_resultCapacity) {
        g_resultCapacity = g_resultCapacity == 0 ? 2 : g_resultCapacity * 2;
        g_result = (char ***)realloc(g_result, sizeof(char **) * g_resultCapacity);
        g_resultColSizes = (int *)realloc(g_resultColSizes, sizeof(int) * g_resultCapacity);
    }
}

static void backtrack(char *s, int start) {
    if (s[start] == '\0') { // Reached the end of the string
        resizeResult();

        // Allocate memory for this partition and copy the strings
        g_result[g_resultSize] = (char **)malloc(sizeof(char *) * g_currentPartitionSize);
        g_resultColSizes[g_resultSize] = g_currentPartitionSize;

        for (int i = 0; i < g_currentPartitionSize; i++) {
            g_result[g_resultSize][i] = strdup(g_currentPartition[i]);
        }
        g_resultSize++;
        return;
    }

    int len = strlen(s);
    for (int i = start; i < len; i++) {
        if (isPalindrome(s, start, i)) {
            // Extract the palindrome substring
            int subLen = i - start + 1;
            char *sub = (char *)malloc(sizeof(char) * (subLen + 1));
            strncpy(sub, s + start, subLen);
            sub[subLen] = '\0';

            // Add to current partition
            resizeCurrentPartition();
            g_currentPartition[g_currentPartitionSize++] = sub;

            // Recurse
            backtrack(s, i + 1);

            // Backtrack: remove from current partition and free memory
            g_currentPartitionSize--;
            free(g_currentPartition[g_currentPartitionSize]); // Free the substring allocated for current partition
        }
    }
}

char ***partition(char *s, int *returnSize, int **returnColumnSizes) {
    // Initialize global variables
    g_result = NULL;
    g_resultColSizes = NULL;
    g_resultSize = 0;
    g_resultCapacity = 0;

    g_currentPartition = NULL;
    g_currentPartitionSize = 0;
    g_currentPartitionCapacity = 0;

    if (s == NULL || strlen(s) == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    backtrack(s, 0);

    *returnSize = g_resultSize;
    *returnColumnSizes = g_resultColSizes;

    // Free the temporary currentPartition array itself
    if (g_currentPartition != NULL) {
        free(g_currentPartition);
    }

    return g_result;
}