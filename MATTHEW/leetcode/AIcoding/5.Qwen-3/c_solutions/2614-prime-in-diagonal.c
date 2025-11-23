#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int isPrime(int n) {
    if (n <= 1) return 0;
    if (n == 2) return 1;
    if (n % 2 == 0) return 0;
    int sqrt_n = (int)sqrt(n);
    for (int i = 3; i <= sqrt_n; i += 2) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int diagonalPrime(int** mat, int matSize, int* matColSize) {
    int max = 0;
    for (int i = 0; i < matSize; i++) {
        int val1 = mat[i][i];
        if (isPrime(val1) && val1 > max) max = val1;
        int val2 = mat[i][matSize - 1 - i];
        if (isPrime(val2) && val2 > max) max = val2;
    }
    return max;
}