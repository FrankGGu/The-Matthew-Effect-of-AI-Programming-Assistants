#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int inventoryManagementIII(int* stock, int stockSize, int cnt) {
    qsort(stock, stockSize, sizeof(int), cmp);
    int sum = 0;
    for (int i = 0; i < cnt; i++) {
        sum += stock[i];
    }
    return sum;
}