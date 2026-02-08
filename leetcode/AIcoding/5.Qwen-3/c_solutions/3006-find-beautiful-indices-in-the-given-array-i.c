#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findBeautifulIndices(char* s, int k, int* returnSize) {
    int n = strlen(s);
    int* result = (int*)malloc(n * sizeof(int));
    int count = 0;

    for (int i = 0; i < n; i++) {
        int found = 0;
        for (int j = 0; j < n; j++) {
            if (i != j && abs(i - j) <= k) {
                if (s[i] == s[j]) {
                    found = 1;
                    break;
                }
            }
        }
        if (found) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}