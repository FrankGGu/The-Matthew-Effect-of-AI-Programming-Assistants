#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* beautifulArray(int n, int* returnSize) {
    int* res = (int*)malloc(sizeof(int) * n);
    *returnSize = n;
    res[0] = 1;
    int len = 1;
    while (len < n) {
        int newLen = len * 2;
        int* temp = (int*)malloc(sizeof(int) * newLen);
        int index = 0;
        for (int i = 0; i < len; i++) {
            if (res[i] * 2 - 1 <= n) {
                temp[index++] = res[i] * 2 - 1;
            }
        }
        for (int i = 0; i < len; i++) {
            if (res[i] * 2 <= n) {
                temp[index++] = res[i] * 2;
            }
        }
        free(res);
        res = temp;
        len = index;
    }
    return res;
}