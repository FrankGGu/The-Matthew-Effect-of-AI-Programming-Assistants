#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *largestPalindrome(int n, int k) {
    if (n == 1) {
        if (k > 9) {
            return "1";
        }
        if (k <= 9) {
            for (int i = 9; i >= 1; i--) {
                if (i % k == 0) {
                    char *res = malloc(2 * sizeof(char));
                    sprintf(res, "%d", i);
                    return res;
                }
            }
            return "0";
        }
    }

    if (k == 1) {
        char *res = malloc((n + 1) * sizeof(char));
        for (int i = 0; i < n; i++) {
            res[i] = '9';
        }
        res[n] = '\0';
        return res;
    }

    char *res = malloc((n + 1) * sizeof(char));
    if (res == NULL) return NULL;
    memset(res, 0, (n + 1) * sizeof(char));

    long long upper = 1;
    for (int i = 1; i < n; i++) upper *= 10;
    long long lower = upper * 10 - 1;

    for (long long i = lower / (long long)pow(10, (n + 1) / 2); i >= upper / (long long)pow(10, (n + 1) / 2); i--) {
        char half[10];
        sprintf(half, "%lld", i);
        int len = strlen(half);

        for (int j = 0; j < len; j++) {
            res[j] = half[j];
        }

        for (int j = 0; j < len; j++) {
            res[n - 1 - j] = half[j];
        }
        res[n] = '\0';

        long long num = atoll(res);

        if (num % k == 0) {
            return res;
        }
    }
    free(res);
    return "0";
}