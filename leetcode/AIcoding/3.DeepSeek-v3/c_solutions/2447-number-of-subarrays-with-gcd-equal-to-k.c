int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int subarrayGCD(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int current_gcd = nums[i];
        for (int j = i; j < numsSize; j++) {
            current_gcd = gcd(current_gcd, nums[j]);
            if (current_gcd == k) {
                count++;
            }
            if (current_gcd < k) {
                break;
            }
        }
    }
    return count;
}