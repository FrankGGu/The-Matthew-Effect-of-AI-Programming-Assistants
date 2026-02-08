int findMaxLength(int* nums, int numsSize) {
    int maxLength = 0;
    int sum = 0;
    int *map = (int *)malloc((2 * numsSize + 1) * sizeof(int));
    for (int i = 0; i < 2 * numsSize + 1; i++) {
        map[i] = -2;
    }
    map[numsSize] = -1;

    for (int i = 0; i < numsSize; i++) {
        sum += (nums[i] == 1) ? 1 : -1;
        if (map[sum + numsSize] == -2) {
            map[sum + numsSize] = i;
        } else {
            maxLength = fmax(maxLength, i - map[sum + numsSize]);
        }
    }

    free(map);
    return maxLength;
}