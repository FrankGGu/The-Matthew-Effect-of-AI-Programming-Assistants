#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>
#include <math.h> // For abs

typedef struct Transaction {
    char name[21];
    int time;
    int amount;
    char city[21];
    bool invalid;
    int originalIndex;
} Transaction;

void parseTransactionString(const char* s, Transaction* t) {
    sscanf(s, "%[^,],%d,%d,%s", t->name, &t->time, &t->amount, t->city);
    t->invalid = false;
}

char** invalidTransactions(char** transactions, int transactionsSize, int* returnSize) {
    if (transactionsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    Transaction* parsedTransactions = (Transaction*)malloc(transactionsSize * sizeof(Transaction));
    if (parsedTransactions == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < transactionsSize; i++) {
        parsedTransactions[i].originalIndex = i;
        parseTransactionString(transactions[i], &parsedTransactions[i]);

        if (parsedTransactions[i].amount > 1000) {
            parsedTransactions[i].invalid = true;
        }
    }

    for (int i = 0; i < transactionsSize; i++) {
        for (int j = i + 1; j < transactionsSize; j++) {
            if (strcmp(parsedTransactions[i].name, parsedTransactions[j].name) == 0 &&
                strcmp(parsedTransactions[i].city, parsedTransactions[j].city) != 0 &&
                abs(parsedTransactions[i].time - parsedTransactions[j].time) <= 60) {

                parsedTransactions[i].invalid = true;
                parsedTransactions[j].invalid = true;
            }
        }
    }

    char** result = NULL;
    *returnSize = 0;
    int capacity = 0;

    for (int i = 0; i < transactionsSize; i++) {
        if (parsedTransactions[i].invalid) {
            if (*returnSize >= capacity) {
                capacity = (capacity == 0) ? 1 : capacity * 2;
                char** newResult = (char**)realloc(result, capacity * sizeof(char*));
                if (newResult == NULL) {
                    for (int k = 0; k < *returnSize; k++) {
                        free(result[k]);
                    }
                    free(result);
                    free(parsedTransactions);
                    *returnSize = 0;
                    return NULL;
                }
                result = newResult;
            }
            result[*returnSize] = strdup(transactions[parsedTransactions[i].originalIndex]);
            if (result[*returnSize] == NULL) {
                for (int k = 0; k < *returnSize; k++) {
                    free(result[k]);
                }
                free(result);
                free(parsedTransactions);
                *returnSize = 0;
                return NULL;
            }
            (*returnSize)++;
        }
    }

    free(parsedTransactions);

    return result;
}