int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int lcm(int a, int b) {
    if (a == 0 || b == 0) {
        return 0;
    }
    return (a / gcd(a, b)) * b;
}

int subarrayLCM(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int current_lcm = 1;
        for (int j = i; j < numsSize; j++) {
            if (nums[j] > k || k % nums[j] != 0) {
                current_lcm = k + 1; 
                break;
            }

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