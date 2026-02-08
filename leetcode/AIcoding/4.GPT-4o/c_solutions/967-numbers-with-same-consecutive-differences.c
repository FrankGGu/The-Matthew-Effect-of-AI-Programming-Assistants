#include <stdio.h>
#include <stdlib.h>

void backtrack(int n, int k, int num, int length, int* res, int* returnSize) {
    if (length == n) {
        res[*returnSize] = num;
        (*returnSize)++;
        return;
    }

    int lastDigit = num % 10;
    if (lastDigit + k < 10) {
        backtrack(n, k, num * 10 + lastDigit + k, length + 1, res, returnSize);
    }
    if (k > 0 && lastDigit - k >= 0) {
        backtrack(n, k, num * 10 + lastDigit - k, length + 1, res, returnSize);
    }
}

int* numsSameConsecDiff(int n, int k, int* returnSize) {
    int* res = (int*)malloc(sizeof(int) * (1 << n));
    *returnSize = 0;

    if (n == 1) {
        res[(*returnSize)++] = 0;
    }

    for (int i = 1; i < 10; i++) {
        backtrack(n, k, i, 1, res, returnSize);
    }

    return res;
}