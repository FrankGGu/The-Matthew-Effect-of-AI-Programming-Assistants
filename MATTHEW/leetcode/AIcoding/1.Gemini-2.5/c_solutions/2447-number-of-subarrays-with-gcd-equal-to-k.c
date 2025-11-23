int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int subarrayGCD(int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        int current_gcd = 0; 
        for (int j = i; j < numsSize; j++) {
            if (nums[j] % k != 0) {
                break;
            }

            if (current_gcd == 0) {
                current_gcd = nums[j];
            } else {
                current_gcd = gcd(current_gcd, nums[j]);
            }

            if (current_gcd == k) {
                count++;
            } else if (current_gcd < k) {
                break;
            }
        }
    }
    return count;
}