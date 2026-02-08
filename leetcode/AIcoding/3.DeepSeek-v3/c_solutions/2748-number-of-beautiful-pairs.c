int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int countBeautifulPairs(int* nums, int numsSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int first = nums[i];
        while (first >= 10) {
            first /= 10;
        }
        for (int j = i + 1; j < numsSize; j++) {
            int last = nums[j] % 10;
            if (gcd(first, last) == 1) {
                count++;
            }
        }
    }
    return count;
}