int countDistinctIntegers(int* nums, int numsSize) {
    int seen[1000001] = {0};
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (!seen[nums[i]]) {
            seen[nums[i]] = 1;
            count++;
        }

        int rev = 0;
        int n = nums[i];
        while (n > 0) {
            rev = rev * 10 + n % 10;
            n /= 10;
        }

        if (!seen[rev]) {
            seen[rev] = 1;
            count++;
        }
    }

    return count;
}