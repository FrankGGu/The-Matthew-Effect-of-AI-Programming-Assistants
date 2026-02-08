int findMaxLength(int* nums, int numsSize) {
    int maxLength = 0;
    int count = 0;
    int* map = (int*)calloc(2 * numsSize + 1, sizeof(int));
    for (int i = 0; i < 2 * numsSize + 1; i++) {
        map[i] = -2;
    }
    map[numsSize] = -1;

    for (int i = 0; i < numsSize; i++) {
        count += (nums[i] == 1) ? 1 : -1;
        if (map[count + numsSize] == -2) {
            map[count + numsSize] = i;
        } else {
            maxLength = fmax(maxLength, i - map[count + numsSize]);
        }
    }

    free(map);
    return maxLength;
}