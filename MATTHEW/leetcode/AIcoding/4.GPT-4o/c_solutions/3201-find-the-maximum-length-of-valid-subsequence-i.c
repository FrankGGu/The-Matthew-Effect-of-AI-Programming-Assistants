int findMaxLength(int* nums, int numsSize) {
    int maxLength = 0;
    int count[2 * numsSize + 1];
    memset(count, -1, sizeof(count));
    count[numsSize] = 0;

    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += (nums[i] == 0) ? -1 : 1;
        if (count[sum + numsSize] != -1) {
            maxLength = fmax(maxLength, i + 1 - count[sum + numsSize]);
        } else {
            count[sum + numsSize] = i + 1;
        }
    }

    return maxLength;
}