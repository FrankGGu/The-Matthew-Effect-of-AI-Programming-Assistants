#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* createCharArray(int size) {
    char* arr = (char*)malloc((size + 1) * sizeof(char));
    return arr;
}

void freeCharArray(char* arr) {
    free(arr);
}

int countGoodStrings(int n, int k) {
    int dp[2][2];
    dp[0][0] = 1;
    dp[0][1] = 0;
    for (int i = 1; i <= n; i++) {
        dp[i % 2][0] = (dp[(i - 1) % 2][0] + dp[(i - 1) % 2][1]) % k;
        dp[i % 2][1] = dp[(i - 1) % 2][0] % k;
    }
    return (dp[n % 2][0] + dp[n % 2][1]) % k;
}

char* getGoodString(int n, int k) {
    int len = n;
    char* result = createCharArray(len);
    int count = 0;
    for (int i = 0; i < (1 << n); i++) {
        int a = 0;
        int b = 0;
        for (int j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                a++;
                b = 0;
            } else {
                b++;
            }
            if (a >= k || b >= k) {
                break;
            }
        }
        if (a < k && b < k) {
            count++;
        }
    }
    result = createCharArray(count);
    int idx = 0;
    for (int i = 0; i < (1 << n); i++) {
        int a = 0;
        int b = 0;
        for (int j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                a++;
                b = 0;
            } else {
                b++;
            }
            if (a >= k || b >= k) {
                break;
            }
        }
        if (a < k && b < k) {
            for (int j = 0; j < n; j++) {
                result[idx++] = ((i >> j) & 1) ? 'a' : 'b';
            }
            result[idx++] = '\0';
        }
    }
    return result;
}

char* findAllGoodStrings(int n, int k) {
    int total = countGoodStrings(n, k);
    char* result = createCharArray(total * n);
    int idx = 0;
    for (int i = 0; i < (1 << n); i++) {
        int a = 0;
        int b = 0;
        for (int j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                a++;
                b = 0;
            } else {
                b++;
            }
            if (a >= k || b >= k) {
                break;
            }
        }
        if (a < k && b < k) {
            for (int j = 0; j < n; j++) {
                result[idx++] = ((i >> j) & 1) ? 'a' : 'b';
            }
            result[idx++] = '\0';
        }
    }
    return result;
}