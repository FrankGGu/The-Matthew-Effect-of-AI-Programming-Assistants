#include <stdio.h>
#include <stdlib.h>

int* minOperations(char* boxes, int* returnSize) {
    int n = 0;
    while (boxes[n] != '\0') n++;

    int* result = (int*)malloc(n * sizeof(int));
    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));

    int count = 0;
    int ops = 0;
    for (int i = 0; i < n; i++) {
        left[i] = ops;
        if (boxes[i] == '1') {
            count++;
        }
        ops += count;
    }

    count = 0;
    ops = 0;
    for (int i = n - 1; i >= 0; i--) {
        right[i] = ops;
        if (boxes[i] == '1') {
            count++;
        }
        ops += count;
    }

    for (int i = 0; i < n; i++) {
        result[i] = left[i] + right[i];
    }

    free(left);
    free(right);
    *returnSize = n;
    return result;
}