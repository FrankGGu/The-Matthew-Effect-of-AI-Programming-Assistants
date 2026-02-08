int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int minOperations(int* nums, int numsSize) {
    int ones = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 1) ones++;
    }
    if (ones > 0) return numsSize - ones;

    int min_len = numsSize + 1;
    for (int i = 0; i < numsSize; i++) {
        int g = nums[i];
        for (int j = i; j < numsSize; j++) {
            g = gcd(g, nums[j]);
            if (g == 1) {
                min_len = (j - i + 1) < min_len ? (j - i + 1) : min_len;
                break;
            }
        }
    }

    if (min_len == numsSize + 1) return -1;
    return min_len - 1 + numsSize - 1;
}