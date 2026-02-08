#include <stdbool.h>

bool isPrime(int n) {
    if (n <= 1) {
        return false;
    }
    if (n == 2) {
        return true;
    }
    if (n % 2 == 0) {
        return false;
    }
    for (int i = 3; i * i <= n; i += 2) {
        if (n % i == 0) {
            return false;
        }
    }
    return true;
}

int largestPrimeInDiagonal(int** nums, int numsSize, int* numsColSize) {
    int maxPrime = 0;

    for (int i = 0; i < numsSize; i++) {
        int num1 = nums[i][i];
        if (isPrime(num1) && num1 > maxPrime) {
            maxPrime = num1;
        }

        int num2 = nums[i][numsSize - 1 - i];
        if (isPrime(num2) && num2 > maxPrime) {
            maxPrime = num2;
        }
    }

    return maxPrime;
}