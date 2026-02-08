#include <stdio.h>
#include <string.h>

char **commonChars(char **A, int ASize, int* returnSize) {
    int freq[26] = {0};
    int i, j;
    *returnSize = 0;

    for (i = 0; i < strlen(A[0]); i++) {
        freq[A[0][i] - 'a']++;
    }

    for (i = 1; i < ASize; i++) {
        int temp[26] = {0};
        for (j = 0; j < strlen(A[i]); j++) {
            temp[A[i][j] - 'a']++;
        }
        for (j = 0; j < 26; j++) {
            freq[j] = freq[j] < temp[j] ? freq[j] : temp[j];
        }
    }

    char **result = (char **)malloc(26 * sizeof(char *));
    for (i = 0; i < 26; i++) {
        for (j = 0; j < freq[i]; j++) {
            result[*returnSize] = (char *)malloc(2 * sizeof(char));
            result[*returnSize][0] = 'a' + i;
            result[*returnSize][1] = '\0';
            (*returnSize)++;
        }
    }

    return result;
}