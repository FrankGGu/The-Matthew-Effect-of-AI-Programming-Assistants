int findMaxLength(int* nums, int numsSize) {
    int maxLen = 0;
    int count = 0;
    int* map = (int*)malloc((2 * numsSize + 1) * sizeof(int));

    for (int i = 0; i < 2 * numsSize + 1; i++) {
        map[i] = -2;
    }

    map[numsSize] = -1;

    for (int i = 0; i < numsSize; i++) {
        count += (nums[i] == 1) ? 1 : -1;

        if (map[count + numsSize] != -2) {
            maxLen = (i - map[count + numsSize] > maxLen) ? i - map[count + numsSize] : maxLen;
        } else {
            map[count + numsSize] = i;
        }
    }

    free(map);
    return maxLen;
}