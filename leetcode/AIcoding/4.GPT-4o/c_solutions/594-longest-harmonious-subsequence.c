int findLHS(int* nums, int numsSize) {
    int count[20001] = {0};
    int maxLength = 0;

    for (int i = 0; i < numsSize; i++) {
        count[nums[i] + 10000]++;
    }

    for (int i = 1; i < 20001; i++) {
        if (count[i] > 0 && count[i - 1] > 0) {
            maxLength = fmax(maxLength, count[i] + count[i - 1]);
        }
    }

    return maxLength;
}