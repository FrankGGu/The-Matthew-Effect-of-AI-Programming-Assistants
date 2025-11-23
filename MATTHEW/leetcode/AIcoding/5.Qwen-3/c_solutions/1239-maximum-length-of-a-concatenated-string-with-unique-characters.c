#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int uniqueCharacters(char *s) {
    int seen[26] = {0};
    for (int i = 0; s[i]; i++) {
        if (seen[s[i] - 'a']) return 0;
        seen[s[i] - 'a'] = 1;
    }
    return 1;
}

void backtrack(char **arr, int n, int index, int *maxLen, char *current, int currentLen) {
    if (index == n) {
        *maxLen = max(*maxLen, currentLen);
        return;
    }

    // Skip current string
    backtrack(arr, n, index + 1, maxLen, current, currentLen);

    // Include current string if it has unique characters and no overlap with current
    if (uniqueCharacters(arr[index])) {
        int overlap = 0;
        for (int i = 0; arr[index][i]; i++) {
            if (strchr(current, arr[index][i])) {
                overlap = 1;
                break;
            }
        }
        if (!overlap) {
            int len = strlen(arr[index]);
            char *newCurrent = (char *)malloc(currentLen + len + 1);
            strcpy(newCurrent, current);
            strcat(newCurrent, arr[index]);
            backtrack(arr, n, index + 1, maxLen, newCurrent, currentLen + len);
            free(newCurrent);
        }
    }
}

int maxLength(char **arr, int arrSize) {
    int maxLen = 0;
    char *current = (char *)malloc(1);
    current[0] = '\0';
    backtrack(arr, arrSize, 0, &maxLen, current, 0);
    free(current);
    return maxLen;
}