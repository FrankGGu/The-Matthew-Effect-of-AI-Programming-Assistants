#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** findPrimePairs(int n, int* returnSize, int** returnColumnSizes) {
    bool isPrime[n + 1];
    for (int i = 0; i <= n; i++) {
        isPrime[i] = true;
    }
    isPrime[0] = isPrime[1] = false;
    for (int p = 2; p * p <= n; p++) {
        if (isPrime[p]) {
            for (int i = p * p; i <= n; i += p) {
                isPrime[i] = false;
            }
        }
    }

    int count = 0;
    for (int i = 2; i <= n / 2; i++) {
        if (isPrime[i] && isPrime[n - i]) {
            count++;
        }
    }

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = count;

    int index = 0;
    for (int i = 2; i <= n / 2; i++) {
        if (isPrime[i] && isPrime[n - i]) {
            result[index] = (int*)malloc(2 * sizeof(int));
            result[index][0] = i;
            result[index][1] = n - i;
            (*returnColumnSizes)[index] = 2;
            index++;
        }
    }

    return result;
}