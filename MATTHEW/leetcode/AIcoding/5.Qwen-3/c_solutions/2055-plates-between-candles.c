#include <stdio.h>
#include <stdlib.h>

int* platesBetweenCandles(char* s, int* queries, int queriesSize, int* returnSize) {
    int n = strlen(s);
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));
    int* prefix = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        if (s[i] == '*') {
            prefix[i] = (i > 0 ? prefix[i - 1] : 0) + 1;
        } else {
            prefix[i] = (i > 0 ? prefix[i - 1] : 0);
        }
    }

    left[0] = (s[0] == '*') ? 0 : -1;
    for (int i = 1; i < n; i++) {
        left[i] = (s[i] == '*') ? i : left[i - 1];
    }

    right[n - 1] = (s[n - 1] == '*') ? n - 1 : -1;
    for (int i = n - 2; i >= 0; i--) {
        right[i] = (s[i] == '*') ? i : right[i + 1];
    }

    for (int i = 0; i < queriesSize; i++) {
        int l = queries[i];
        int r = queries[i + 1];
        int leftCandle = right[l];
        int rightCandle = left[r];
        if (leftCandle == -1 || rightCandle == -1 || leftCandle >= rightCandle) {
            result[i] = 0;
        } else {
            result[i] = prefix[rightCandle] - prefix[leftCandle];
        }
    }

    free(left);
    free(right);
    free(prefix);
    return result;
}