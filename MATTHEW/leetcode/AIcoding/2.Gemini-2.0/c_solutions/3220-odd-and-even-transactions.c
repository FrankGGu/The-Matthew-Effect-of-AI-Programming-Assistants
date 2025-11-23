#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Transaction {
    int id;
    int amount;
};

int* oddEvenTransactions(struct Transaction* transactions, int transactionsSize, int* returnSize) {
    int oddSum = 0;
    int evenSum = 0;
    int oddCount = 0;
    int evenCount = 0;

    for (int i = 0; i < transactionsSize; i++) {
        if (transactions[i].id % 2 == 0) {
            evenSum += transactions[i].amount;
            evenCount++;
        } else {
            oddSum += transactions[i].amount;
            oddCount++;
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    result[0] = oddSum;
    result[1] = evenSum;
    *returnSize = 2;

    return result;
}