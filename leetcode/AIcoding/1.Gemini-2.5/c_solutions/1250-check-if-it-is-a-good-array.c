int gcd(int a, int b) {
    while (b) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

bool isGoodArray(int* nums, int numsSize) {
    if (numsSize == 0) {
        return false; 
    }

    int result_gcd = nums[0];
    for (int i = 1; i < numsSize; i++) {
        result_gcd = gcd(result_gcd, nums[i]);
        if (result_gcd == 1) {
            return true;
        }
    }

    return result_gcd == 1;
}