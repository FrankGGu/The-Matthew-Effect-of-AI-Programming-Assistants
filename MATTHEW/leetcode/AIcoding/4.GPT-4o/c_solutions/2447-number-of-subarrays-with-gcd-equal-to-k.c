int subarrayGCD(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int gcd = 0;
        for (int j = i; j < numsSize; j++) {
            gcd = (j == i) ? nums[j] : gcd2(gcd, nums[j]);
            if (gcd < k) break;
            if (gcd == k) count++;
        }
    }
    return count;
}

int gcd2(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}