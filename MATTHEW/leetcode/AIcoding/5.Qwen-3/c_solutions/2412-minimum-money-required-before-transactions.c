#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int x = *(int*)a;
    int y = *(int*)b;
    return (x > y) - (x < y);
}

int minimumMoney(struct Transaction* transactions, int transactionsSize) {
    int* temp = (int*)malloc(transactionsSize * sizeof(int));
    for (int i = 0; i < transactionsSize; i++) {
        temp[i] = transactions[i].amount;
    }
    qsort(temp, transactionsSize, sizeof(int), compare);

    int total = 0;
    for (int i = 0; i < transactionsSize; i++) {
        total += temp[i];
    }

    free(temp);
    return total;
}