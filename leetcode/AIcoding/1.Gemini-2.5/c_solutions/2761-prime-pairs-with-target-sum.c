#include <stdlib.h>
#include <stdbool.h>

int** primePairs(int n, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;

    int** result = (int**)malloc(sizeof(int*));
    result[0] = (int*)malloc(sizeof(int) * 2);
    *returnColumnSizes = (int*)malloc(sizeof(int));
    (*returnColumnSizes)[0] = 2;
    *returnSize = 1;

    if (n < 4) {
        result[0][0] = -1;
        result[0][1] = -1;
        return result;
    }

    bool* isPrime = (bool*)malloc(sizeof(bool) * (n + 1));
    for (int i = 0; i <= n; i++) {
        isPrime[i] = true;
    }
    isPrime[0] = false;
    isPrime[1] = false;

    for (int p = 2; p * p <= n; p++) {
        if (isPrime[p]) {
            for (int i = p * p; i <= n; i += p)
                isPrime[i] = false;
        }
    }

    for (int num1 = 2; num1 <= n / 2; num1++) {
        if (isPrime[num1]) {
            int num2 = n - num1;
            if (num2 >= 2 && isPrime[num2]) { // num2 must also be at least 2 to be prime
                result[0][0] = num1;
                result[0][1] = num2;
                free(isPrime);
                return result;
            }
        }
    }

    result[0][0] = -1;
    result[0][1] = -1;
    free(isPrime);
    return result;
}