#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** findAccounts(char** users, int usersSize, int* accountsSize, int** transactions, int transactionsSize, int* transactionsColSize, int* returnSize) {
    int* balance = (int*)calloc(usersSize, sizeof(int));
    for (int i = 0; i < transactionsSize; i++) {
        int account = transactions[i][0] - 1;
        int amount = transactions[i][1];
        balance[account] += amount;
    }

    char** result = NULL;
    *returnSize = 0;
    for (int i = 0; i < usersSize; i++) {
        if (balance[i] > 10000) {
            result = (char**)realloc(result, (*returnSize + 1) * sizeof(char*));
            result[*returnSize] = (char*)malloc(100 * sizeof(char));
            sprintf(result[*returnSize], "%s %d", users[i], balance[i]);
            (*returnSize)++;
        }
    }

    free(balance);
    return result;
}