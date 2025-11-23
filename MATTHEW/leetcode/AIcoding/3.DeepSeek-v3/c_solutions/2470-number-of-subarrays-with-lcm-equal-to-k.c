int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

long long lcm(int a, int b) {
    return (long long)a * b / gcd(a, b);
}

int subarrayLCM(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        long long current_lcm = nums[i];
        for (int j = i; j < numsSize; j++) {
            current_lcm = lcm(current_lcm, nums[j]);
            if (current_lcm == k) {
                count++;
            }
            if (current_lcm > k) {
                break;
            }
        }
    }
    return count;
}