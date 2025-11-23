#include <stdlib.h>

int* oddEvenTransactions(int* transactions, int transactionsSize, int* returnSize) {
    long long evenValueSum = 0;
    long long oddValueSum = 0;

    for (int i = 0; i < transactionsSize; i++) {
        if (transactions[i] % 2 == 0) {
            evenValueSum += transactions[i];
        } else {
            oddValueSum += transactions[i];
        }
    }

    int* result = (int*)malloc(sizeof(int) * 2);
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    result[0] = (int)evenValueSum;
    result[1] = (int)oddValueSum;

    *returnSize = 2;
    return result;
}