#include <math.h>

bool isPrime(int n) {
    if (n <= 1) return false;
    if (n == 2) return true;
    if (n % 2 == 0) return false;

    for (int i = 3; i <= sqrt(n); i += 2) {
        if (n % i == 0) return false;
    }
    return true;
}

int diagonalPrime(int** nums, int numsSize, int* numsColSize) {
    int maxPrime = 0;

    for (int i = 0; i < numsSize; i++) {
        int mainDiag = nums[i][i];
        int antiDiag = nums[i][numsSize - 1 - i];

        if (isPrime(mainDiag) && mainDiag > maxPrime) {
            maxPrime = mainDiag;
        }

        if (isPrime(antiDiag) && antiDiag > maxPrime) {
            maxPrime = antiDiag;
        }
    }

    return maxPrime;
}