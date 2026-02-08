#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *account;
    int income;
} AccountSummary;

int compare(const void *a, const void *b) {
    return strcmp(((AccountSummary *)a)->account, ((AccountSummary *)b)->account);
}

AccountSummary* getAccountStatus(int** accounts, int accountsSize, int* accountsColSize, int* resSize) {
    int i;
    AccountSummary *result = (AccountSummary *)malloc(accountsSize * sizeof(AccountSummary));
    *resSize = 0;

    for (i = 0; i < accountsSize; i++) {
        int sum = 0;
        for (int j = 1; j < accountsColSize[i]; j++) {
            sum += accounts[i][j];
        }
        result[*resSize].account = (char *)malloc(10 * sizeof(char));
        sprintf(result[*resSize].account, "%d", accounts[i][0]);
        result[*resSize].income = sum;
        (*resSize)++;
    }

    qsort(result, *resSize, sizeof(AccountSummary), compare);
    return result;
}