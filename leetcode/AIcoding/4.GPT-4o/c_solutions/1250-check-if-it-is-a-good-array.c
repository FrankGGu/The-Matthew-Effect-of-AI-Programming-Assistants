int isGoodArray(int* nums, int numsSize) {
    int gcd = nums[0];
    for (int i = 1; i < numsSize; i++) {
        int a = gcd, b = nums[i];
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        gcd = a;
    }
    return gcd == 1;
}