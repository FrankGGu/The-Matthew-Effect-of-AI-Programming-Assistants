#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* sequentialDigits(int n, int* returnSize) {
    int* result = (int*)malloc(100 * sizeof(int));
    int index = 0;

    for (int i = 1; i <= 9; i++) {
        int num = i;
        for (int j = i + 1; j <= 9; j++) {
            num = num * 10 + j;
            if (num >= n) {
                result[index++] = num;
            }
        }
    }

    *returnSize = index;
    return result;
}