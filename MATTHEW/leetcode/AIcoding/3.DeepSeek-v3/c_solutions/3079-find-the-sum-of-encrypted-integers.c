int sumOfEncryptedNumbers(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int maxDigit = 0;
        int count = 0;

        while (num > 0) {
            int digit = num % 10;
            if (digit > maxDigit) {
                maxDigit = digit;
            }
            num /= 10;
            count++;
        }

        int encrypted = 0;
        for (int j = 0; j < count; j++) {
            encrypted = encrypted * 10 + maxDigit;
        }

        total += encrypted;
    }
    return total;
}