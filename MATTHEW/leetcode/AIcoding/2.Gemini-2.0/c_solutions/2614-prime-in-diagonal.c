#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i <= sqrt(n); i++) {
        if (n % i == 0) return false;
    }
    return true;
}

int diagonalPrime(int** nums, int numsSize, int* numsColSize){
    int maxPrime = 0;
    for (int i = 0; i < numsSize; i++) {
        if (isPrime(nums[i][i])) {
            if (nums[i][i] > maxPrime) {
                maxPrime = nums[i][i];
            }
        }
        if (isPrime(nums[i][numsSize - 1 - i])) {
            if (nums[i][numsSize - 1 - i] > maxPrime) {
                maxPrime = nums[i][numsSize - 1 - i];
            }
        }
    }
    return maxPrime;
}