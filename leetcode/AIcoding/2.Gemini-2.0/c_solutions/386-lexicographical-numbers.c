#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* lexicalOrder(int n, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * n);
    *returnSize = n;
    int curr = 1;
    for (int i = 0; i < n; i++) {
        result[i] = curr;
        if (curr * 10 <= n) {
            curr *= 10;
        } else {
            if (curr >= n) {
                curr /= 10;
            }
            curr++;
            while (curr % 10 == 0) {
                curr /= 10;
            }
        }
    }
    return result;
}