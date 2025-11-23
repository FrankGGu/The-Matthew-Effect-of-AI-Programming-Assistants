#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char name[21];
    int time;
    int amount;
    char city[21];
} Transaction;

int compare(const void *a, const void *b) {
    return strcmp(((Transaction *)a)->name, ((Transaction *)b)->name);
}

int invalidTransactions(char **transactions, int transactionsSize, char ***invalidTransactions) {
    Transaction *trans = malloc(transactionsSize * sizeof(Transaction));
    int invalidCount = 0;

    for (int i = 0; i < transactionsSize; i++) {
        sscanf(transactions[i], "%[^,],%d,%d,%[^,]", trans[i].name, &trans[i].time, &trans[i].amount, trans[i].city);
    }

    qsort(trans, transactionsSize, sizeof(Transaction), compare);

    for (int i = 0; i < transactionsSize; i++) {
        if (trans[i].amount > 1000) {
            invalidCount++;
        }
    }

    for (int i = 0; i < transactionsSize; i++) {
        if (trans[i].amount <= 1000) {
            for (int j = 0; j < transactionsSize; j++) {
                if (i != j && strcmp(trans[i].name, trans[j].name) == 0 && abs(trans[i].time - trans[j].time) <= 60 && strcmp(trans[i].city, trans[j].city) != 0) {
                    invalidCount++;
                    break;
                }
            }
        }
    }

    *invalidTransactions = malloc(invalidCount * sizeof(char *));
    int index = 0;
    for (int i = 0; i < transactionsSize; i++) {
        if (trans[i].amount > 1000 || (strcmp(trans[i].city, trans[i].city) != 0 && abs(trans[i].time - trans[i].time) <= 60)) {
            (*invalidTransactions)[index] = malloc(256 * sizeof(char));
            sprintf((*invalidTransactions)[index], "%s", transactions[i]);
            index++;
        }
    }

    free(trans);
    return invalidCount;
}