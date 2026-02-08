#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* addToArrayForm(int* num, int numSize, int k, int* returnSize){
    int len = numSize > 5 ? numSize + 20 : numSize + 20;
    int *res = (int*)malloc(sizeof(int) * len);
    int i = numSize - 1;
    int carry = 0;
    int idx = 0;

    while (i >= 0 || k > 0 || carry > 0) {
        int digit = carry;
        if (i >= 0) {
            digit += num[i];
            i--;
        }
        if (k > 0) {
            digit += k % 10;
            k /= 10;
        }
        res[idx++] = digit % 10;
        carry = digit / 10;
    }

    int *finalRes = (int*)malloc(sizeof(int) * idx);
    *returnSize = idx;
    for (int j = 0; j < idx; j++) {
        finalRes[j] = res[idx - 1 - j];
    }

    free(res);
    return finalRes;
}