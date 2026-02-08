#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* guardCity(int* security, int securitySize, int k, int* returnSize) {
    *returnSize = 0;
    if (security == NULL || securitySize == 0 || k <= 0) return NULL;

    int n = securitySize;
    int* result = (int*)malloc(n * sizeof(int));
    int count = 0;

    for (int i = 0; i < n; i++) {
        int sum = 0;
        for (int j = i; j < i + k && j < n; j++) {
            sum += security[j];
        }
        if (sum > 0) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}