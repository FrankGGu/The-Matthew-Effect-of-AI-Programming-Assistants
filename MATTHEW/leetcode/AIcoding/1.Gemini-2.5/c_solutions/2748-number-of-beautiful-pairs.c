int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int countBeautifulPairs(int* nums, int numsSize) {
    int beautifulPairsCount = 0;

    for (int i = 0; i < numsSize; i++) {
        int firstDigit = nums[i];
        while (firstDigit >= 10) {
            firstDigit /= 10;
        }

        for (int j = i + 1; j < numsSize; j++) {
            int lastDigit = nums[j] % 10;

            if (gcd(firstDigit, lastDigit) == 1) {
                beautifulPairsCount++;
            }
        }
    }
    return beautifulPairsCount;
}