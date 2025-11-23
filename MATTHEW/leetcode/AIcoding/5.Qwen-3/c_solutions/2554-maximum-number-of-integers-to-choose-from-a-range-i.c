#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxChooseInteger(int* banned, int bannedSize, int n) {
    qsort(banned, bannedSize, sizeof(int), cmpfunc);
    int count = 0;
    int current = 1;
    for (int i = 0; i < bannedSize; i++) {
        if (banned[i] > current) {
            count++;
            current++;
        } else if (banned[i] == current) {
            current++;
        }
    }
    if (current <= n) {
        count++;
    }
    return count;
}