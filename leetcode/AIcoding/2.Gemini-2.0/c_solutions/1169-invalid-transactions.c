#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char name[21];
    int time;
    int amount;
    char city[21];
    int index;
} Transaction;

char ** invalidTransactions(char ** transactions, int transactionsSize, int* returnSize){
    Transaction *trans = (Transaction*)malloc(sizeof(Transaction) * transactionsSize);
    for (int i = 0; i < transactionsSize; i++) {
        char *token;
        token = strtok(transactions[i], ",");
        strcpy(trans[i].name, token);
        token = strtok(NULL, ",");
        trans[i].time = atoi(token);
        token = strtok(NULL, ",");
        trans[i].amount = atoi(token);
        token = strtok(NULL, ",");
        strcpy(trans[i].city, token);
        trans[i].index = i;
    }

    int *invalid = (int*)calloc(transactionsSize, sizeof(int));
    for (int i = 0; i < transactionsSize; i++) {
        if (trans[i].amount > 1000) {
            invalid[i] = 1;
        }
        for (int j = i + 1; j < transactionsSize; j++) {
            if (strcmp(trans[i].name, trans[j].name) == 0 &&
                strcmp(trans[i].city, trans[j].city) != 0 &&
                abs(trans[i].time - trans[j].time) <= 60) {
                invalid[i] = 1;
                invalid[j] = 1;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < transactionsSize; i++) {
        if (invalid[i]) {
            count++;
        }
    }

    char **result = (char**)malloc(sizeof(char*) * count);
    int index = 0;
    for (int i = 0; i < transactionsSize; i++) {
        if (invalid[i]) {
            result[index] = (char*)malloc(sizeof(char) * (strlen(transactions[i]) + 1));
            strcpy(result[index], transactions[i]);
            index++;
        }
    }

    *returnSize = count;
    free(trans);
    free(invalid);
    return result;
}