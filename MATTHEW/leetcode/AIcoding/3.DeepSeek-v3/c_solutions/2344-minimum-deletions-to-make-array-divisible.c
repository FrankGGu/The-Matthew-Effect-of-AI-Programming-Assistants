int minOperations(int* nums, int numsSize, int* numsDivide, int numsDivideSize) {
    int gcd_val = numsDivide[0];
    for (int i = 1; i < numsDivideSize; i++) {
        int a = gcd_val;
        int b = numsDivide[i];
        while (b) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        gcd_val = a;
    }

    int min_num = INT_MAX;
    for (int i = 0; i < numsSize; i++) {
        if (gcd_val % nums[i] == 0 && nums[i] < min_num) {
            min_num = nums[i];
        }
    }

    if (min_num == INT_MAX) return -1;

    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < min_num) {
            count++;
        }
    }

    return count;
}