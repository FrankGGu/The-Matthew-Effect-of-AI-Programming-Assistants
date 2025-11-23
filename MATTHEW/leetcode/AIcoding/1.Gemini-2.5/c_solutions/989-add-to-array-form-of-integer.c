#include <stdlib.h>

int* addToArrayForm(int* num, int numSize, int k, int* returnSize) {
    int maxLength = numSize + 11; 
    int* result = (int*)malloc(sizeof(int) * maxLength);
    int writeIdx = maxLength - 1;

    int i = numSize - 1;
    int carry = 0;

    while (i >= 0 || k > 0 || carry > 0) {
        int currentSum = carry;

        if (i >= 0) {
            currentSum += num[i];
            i--;
        }

        if (k > 0) {
            currentSum += k % 10;
            k /= 10;
        }

        result[writeIdx] = currentSum % 10;
        carry = currentSum / 10;
        writeIdx--;
    }

    int actualStartIdx = writeIdx + 1;
    *returnSize = maxLength - actualStartIdx;

    int* finalResult = (int*)malloc(sizeof(int) * (*returnSize));
    for (int j = 0; j < *returnSize; j++) {
        finalResult[j] = result[actualStartIdx + j];
    }
    free(result);

    return finalResult;
}