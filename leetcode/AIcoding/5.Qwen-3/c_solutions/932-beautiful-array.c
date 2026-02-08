#include <stdio.h>
#include <stdlib.h>

int* beautifulArray(int n, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    int* temp = (int*)malloc(n * sizeof(int));
    int left = 0, right = n - 1;

    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            result[left++] = i + 1;
        } else {
            temp[right--] = i + 1;
        }
    }

    int k = 0;
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            result[i] = temp[k++];
        }
    }

    free(temp);
    return result;
}