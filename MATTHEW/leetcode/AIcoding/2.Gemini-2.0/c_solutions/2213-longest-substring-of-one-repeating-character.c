#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int longestRepeating(char * s, char * queryCharacters, int* queryIndices, int queryCount){
    int n = strlen(s);
    int *result = (int*)malloc(queryCount * sizeof(int));

    for (int i = 0; i < queryCount; i++) {
        s[queryIndices[i]] = queryCharacters[i];

        int maxLen = 1;
        for (int j = 0; j < n; j++) {
            int currentLen = 1;
            for (int k = j + 1; k < n; k++) {
                if (s[k] == s[j]) {
                    currentLen++;
                } else {
                    break;
                }
            }
            maxLen = max(maxLen, currentLen);
        }
        result[i] = maxLen;
    }

    return result;
}