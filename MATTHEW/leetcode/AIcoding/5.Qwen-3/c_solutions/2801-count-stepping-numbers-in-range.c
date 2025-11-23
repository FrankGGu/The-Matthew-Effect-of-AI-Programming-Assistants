#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef long long ll;

ll* countSteppingNumbers(int low, int high, int* returnSize) {
    int len = 0;
    for (int i = low; i <= high; i++) {
        int n = i;
        int prev = -1;
        int isStepping = 1;
        while (n > 0) {
            int curr = n % 10;
            if (prev != -1 && abs(curr - prev) != 1) {
                isStepping = 0;
                break;
            }
            prev = curr;
            n /= 10;
        }
        if (isStepping) len++;
    }

    ll* result = (ll*)malloc(len * sizeof(ll));
    int idx = 0;
    for (int i = low; i <= high; i++) {
        int n = i;
        int prev = -1;
        int isStepping = 1;
        while (n > 0) {
            int curr = n % 10;
            if (prev != -1 && abs(curr - prev) != 1) {
                isStepping = 0;
                break;
            }
            prev = curr;
            n /= 10;
        }
        if (isStepping) {
            result[idx++] = i;
        }
    }

    *returnSize = len;
    return result;
}