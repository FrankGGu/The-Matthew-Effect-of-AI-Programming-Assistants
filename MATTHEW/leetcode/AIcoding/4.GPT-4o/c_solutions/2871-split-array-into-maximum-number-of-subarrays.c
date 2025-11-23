int maxSubarrays(int* nums, int numsSize) {
    int count = 0, currentGcd = 0;
    for (int i = 0; i < numsSize; i++) {
        currentGcd = (currentGcd == 0) ? nums[i] : gcd(currentGcd, nums[i]);
        if (currentGcd == 1) {
            count++;
            currentGcd = 0;
        }
    }
    return count;
}

int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}