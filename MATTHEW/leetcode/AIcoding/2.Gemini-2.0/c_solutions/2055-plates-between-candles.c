#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* platesBetweenCandles(char * s, int** queries, int queriesSize, int* queriesColSize, int* returnSize){
    int n = 0;
    while (s[n] != '\0') {
        n++;
    }

    int *left = (int*)malloc(n * sizeof(int));
    int *right = (int*)malloc(n * sizeof(int));
    int *prefixSum = (int*)malloc(n * sizeof(int));

    int lastCandle = -1;
    for (int i = 0; i < n; i++) {
        if (s[i] == '|') {
            lastCandle = i;
        }
        left[i] = lastCandle;
    }

    lastCandle = -1;
    for (int i = n - 1; i >= 0; i--) {
        if (s[i] == '|') {
            lastCandle = i;
        }
        right[i] = lastCandle;
    }

    prefixSum[0] = (s[0] == '*') ? 1 : 0;
    for (int i = 1; i < n; i++) {
        prefixSum[i] = prefixSum[i - 1] + ((s[i] == '*') ? 1 : 0);
    }

    int *result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        int start = queries[i][0];
        int end = queries[i][1];

        int leftCandle = right[start];
        int rightCandle = left[end];

        if (leftCandle == -1 || rightCandle == -1 || leftCandle >= rightCandle) {
            result[i] = 0;
        } else {
            result[i] = prefixSum[rightCandle] - prefixSum[leftCandle];
        }
    }

    free(left);
    free(right);
    free(prefixSum);

    return result;
}