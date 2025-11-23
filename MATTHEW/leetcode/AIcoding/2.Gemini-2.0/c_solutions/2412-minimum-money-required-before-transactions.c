#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[0] - x[1] > y[0] - y[1]) {
        return -1;
    } else if (x[0] - x[1] < y[0] - y[1]) {
        return 1;
    } else {
        return x[0] - y[0];
    }
}

long long minMoney(int** transactions, int transactionsSize, int* transactionsColSize) {
    qsort(transactions, transactionsSize, sizeof(transactions[0]), cmp);

    long long ans = 0;
    long long curr = 0;
    for (int i = 0; i < transactionsSize; i++) {
        if (transactions[i][0] - transactions[i][1] >= 0) {
            ans += transactions[i][0];
        } else {
            curr += transactions[i][0];
            ans = (ans > transactions[i][1]) ? ans : transactions[i][1];
        }
    }
    return ans;
}