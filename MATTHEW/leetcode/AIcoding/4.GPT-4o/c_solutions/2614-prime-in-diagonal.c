int diagonalPrime(int** nums, int numsSize, int* numsColSize) {
    int maxPrime = 0;

    for (int i = 0; i < numsSize; i++) {
        if (isPrime(nums[i][i]) && nums[i][i] > maxPrime) {
            maxPrime = nums[i][i];
        }
        if (isPrime(nums[i][numsSize - 1 - i]) && nums[i][numsSize - 1 - i] > maxPrime) {
            maxPrime = nums[i][numsSize - 1 - i];
        }
    }

    return maxPrime;
}

int isPrime(int num) {
    if (num < 2) return 0;
    for (int i = 2; i * i <= num; i++) {
        if (num % i == 0) return 0;
    }
    return 1;
}