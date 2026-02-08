#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int result;
int* cookies;
int n;
int k;

void backtrack(int index, int* distribution, int* count) {
    if (index == n) {
        int min = 1000000;
        for (int i = 0; i < k; i++) {
            if (count[i] < min) min = count[i];
        }
        if (min > result) result = min;
        return;
    }

    for (int i = 0; i < k; i++) {
        if (distribution[i] + cookies[index] > result) continue;
        distribution[i] += cookies[index];
        count[i]++;
        backtrack(index + 1, distribution, count);
        count[i]--;
        distribution[i] -= cookies[index];
    }
}

int distributeCookies(int* cookies, int cookiesSize, int k) {
    n = cookiesSize;
    this->cookies = cookies;
    this->k = k;
    result = 1000000;
    qsort(cookies, cookiesSize, sizeof(int), compare);
    int* distribution = (int*)malloc(k * sizeof(int));
    int* count = (int*)malloc(k * sizeof(int));
    memset(distribution, 0, k * sizeof(int));
    memset(count, 0, k * sizeof(int));
    backtrack(0, distribution, count);
    free(distribution);
    free(count);
    return result;
}