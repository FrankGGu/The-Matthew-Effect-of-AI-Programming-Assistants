#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* partitionLabels(char* s, int* returnSize) {
    int last[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        last[s[i] - 'a'] = i;
    }

    int* result = (int*)malloc(sizeof(int) * n);
    int index = 0;
    int start = 0;
    for (int i = 0; i < n; i++) {
        if (i == last[s[i] - 'a']) {
            result[index++] = i - start + 1;
            start = i + 1;
        }
    }

    *returnSize = index;
    return result;
}