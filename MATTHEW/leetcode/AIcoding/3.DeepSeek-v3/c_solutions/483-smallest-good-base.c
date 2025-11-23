#include <stdlib.h>
#include <string.h>
#include <math.h>

char* smallestGoodBase(char* n) {
    unsigned long long num = strtoull(n, NULL, 10);
    unsigned long long x = 1;

    for (int m = 60; m >= 2; m--) {
        unsigned long long k = (unsigned long long)pow(num, 1.0 / m);
        if (k < 2) continue;

        unsigned long long sum = 1;
        unsigned long long curr = 1;
        for (int i = 1; i <= m; i++) {
            curr *= k;
            sum += curr;
        }

        if (sum == num) {
            char* result = (char*)malloc(21 * sizeof(char));
            sprintf(result, "%llu", k);
            return result;
        }
    }

    char* result = (char*)malloc(21 * sizeof(char));
    sprintf(result, "%llu", num - 1);
    return result;
}