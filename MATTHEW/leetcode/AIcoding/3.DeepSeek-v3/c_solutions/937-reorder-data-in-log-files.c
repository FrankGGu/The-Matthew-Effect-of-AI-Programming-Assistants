/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int compare(const void* a, const void* b) {
    char* log1 = *(char**)a;
    char* log2 = *(char**)b;

    // Find the first space to separate identifier and content
    char* space1 = strchr(log1, ' ');
    char* space2 = strchr(log2, ' ');

    // Get the content part (after first space)
    char* content1 = space1 + 1;
    char* content2 = space2 + 1;

    // Check if both are digit logs or letter logs
    int isDigit1 = isdigit(content1[0]);
    int isDigit2 = isdigit(content2[0]);

    if (!isDigit1 && !isDigit2) {
        // Both are letter logs
        int cmp = strcmp(content1, content2);
        if (cmp != 0) {
            return cmp;
        }
        // If contents are the same, compare identifiers
        return strcmp(log1, space1 - (content1 - log1));
    }

    if (isDigit1 && isDigit2) {
        // Both are digit logs, maintain relative order
        return 0;
    }

    // One is digit, one is letter
    if (isDigit1 && !isDigit2) {
        return 1;  // digit comes after letter
    } else {
        return -1; // letter comes before digit
    }
}

char** reorderLogFiles(char** logs, int logsSize, int* returnSize) {
    *returnSize = logsSize;

    // Create a copy of the logs array to sort
    char** result = (char**)malloc(logsSize * sizeof(char*));
    for (int i = 0; i < logsSize; i++) {
        result[i] = logs[i];
    }

    qsort(result, logsSize, sizeof(char*), compare);
    return result;
}