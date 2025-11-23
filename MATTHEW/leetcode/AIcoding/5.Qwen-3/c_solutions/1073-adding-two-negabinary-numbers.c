#include <stdio.h>
#include <stdlib.h>

int* addNegabinary(int* a, int aSize, int* b, int bSize, int* returnSize) {
    int* result = (int*)malloc(2 * (aSize + bSize) * sizeof(int));
    int index = 0;

    int i = aSize - 1, j = bSize - 1;
    int carry = 0;

    while (i >= 0 || j >= 0 || carry != 0) {
        int sum = carry;

        if (i >= 0) {
            sum += a[i];
            i--;
        }

        if (j >= 0) {
            sum += b[j];
            j--;
        }

        result[index++] = sum & 1;
        carry = -(sum >> 1);
    }

    // Remove leading zeros
    int k = index - 1;
    while (k >= 0 && result[k] == 0) {
        k--;
    }

    *returnSize = k + 1;
    int* finalResult = (int*)malloc((*returnSize) * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        finalResult[i] = result[k--];
    }

    free(result);
    return finalResult;
}