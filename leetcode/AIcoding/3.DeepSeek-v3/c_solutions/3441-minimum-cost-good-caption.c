#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    return *(char*)a - *(char*)b;
}

long long minimumCost(char* s) {
    int n = strlen(s);
    long long cost = 0;

    for (int i = 0; i < n - 1; i++) {
        if (s[i] != s[i + 1]) {
            cost += (long long)(i + 1) < (long long)(n - i - 1) ? (i + 1) : (n - i - 1);
        }
    }

    return cost;
}