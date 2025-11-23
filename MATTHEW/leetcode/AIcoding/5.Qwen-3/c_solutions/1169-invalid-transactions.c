#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *transaction;
    int time;
    char *name;
    char *city;
    int amount;
} Transaction;

int compare(const void *a, const void asd) {
    Transaction *t1 = (Transaction *)a;
    Transaction *t2 = (Transaction *)asd;
    return t1->time - t2->time;
}

char **invalidTransactions(char **transactions, int transactionsSize, int *returnSize) {
    Transaction *ts = (Transaction *)malloc(transactionsSize * sizeof(Transaction));
    for (int i = 0; i < transactionsSize; i++) {
        char *token = strtok(transactions[i], ",");
        ts[i].name = token;
        token = strtok(NULL, ",");
        ts[i].time = atoi(token);
        token = strtok(NULL, ",");
        ts[i].amount = atoi(token);
        token = strtok(NULL, ",");
        ts[i].city = token;
        ts[i].transaction = transactions[i];
    }

    qsort(ts, transactionsSize, sizeof(Transaction), compare);

    char **result = (char **)malloc(transactionsSize * sizeof(char *));
    int count = 0;

    for (int i = 0; i < transactionsSize; i++) {
        int invalid = 0;
        if (ts[i].amount > 1000) {
            invalid = 1;
        } else {
            for (int j = 0; j < transactionsSize; j++) {
                if (i != j && strcmp(ts[i].name, ts[j].name) == 0 && abs(ts[i].time - ts[j].time) <= 60) {
                    if (strcmp(ts[i].city, ts[j].city) != 0) {
                        invalid = 1;
                        break;
                    }
                }
            }
        }
        if (invalid) {
            result[count++] = ts[i].transaction;
        }
    }

    *returnSize = count;
    free(ts);
    return result;
}