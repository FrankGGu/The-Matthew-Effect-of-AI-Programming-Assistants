#include <stdio.h>
#include <stdlib.h>

int* distinctDifferenceArray(char* s, int* returnSize) {
    int n = 0;
    while (s[n] != '\0') n++;

    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    for (int i = 0; i < n; i++) {
        int countUniqueBefore = 0;
        int seenBefore[256] = {0};
        for (int j = 0; j <= i; j++) {
            if (!seenBefore[s[j]]) {
                seenBefore[s[j]] = 1;
                countUniqueBefore++;
            }
        }

        int countUniqueAfter = 0;
        int seenAfter[256] = {0};
        for (int j = i + 1; j < n; j++) {
            if (!seenAfter[s[j]]) {
                seenAfter[s[j]] = 1;
                countUniqueAfter++;
            }
        }

        result[i] = countUniqueBefore - countUniqueAfter;
    }

    return result;
}