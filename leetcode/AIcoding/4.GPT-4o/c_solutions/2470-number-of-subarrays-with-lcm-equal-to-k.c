int subarrayLCM(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int lcm = 1;
        for (int j = i; j < numsSize; j++) {
            lcm = lcm / gcd(lcm, nums[j]) * nums[j];
            if (lcm > k) break;
            if (lcm == k) count++;
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