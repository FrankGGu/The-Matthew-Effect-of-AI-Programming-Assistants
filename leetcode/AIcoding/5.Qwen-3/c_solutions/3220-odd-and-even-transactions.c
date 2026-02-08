#include <stdio.h>
#include <stdlib.h>

int* oddEven(int* transactions, int transactionsSize, int* returnSize) {
    int* result = (int*)malloc(transactionsSize * sizeof(int));
    int evenIndex = 0;
    int oddIndex = 0;

    for (int i = 0; i < transactionsSize; i++) {
        if (transactions[i] % 2 == 0) {
            result[evenIndex++] = transactions[i];
        } else {
            result[transactionsSize - 1 - oddIndex++] = transactions[i];
        }
    }

    *returnSize = transactionsSize;
    return result;
}