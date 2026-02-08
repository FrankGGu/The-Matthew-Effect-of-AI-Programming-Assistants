char* optimalDivision(int* nums, int numsSize) {
    if (numsSize == 1) {
        char* result = malloc(12);
        sprintf(result, "%d", nums[0]);
        return result;
    }
    if (numsSize == 2) {
        char* result = malloc(24);
        sprintf(result, "%d/%d", nums[0], nums[1]);
        return result;
    }

    int length = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        if (num < 0) num = -num;
        while (num > 0) {
            length++;
            num /= 10;
        }
        length++;
    }
    length += numsSize * 2;

    char* result = malloc(length);
    int pos = 0;

    pos += sprintf(result + pos, "%d/(", nums[0]);
    for (int i = 1; i < numsSize - 1; i++) {
        pos += sprintf(result + pos, "%d/", nums[i]);
    }
    pos += sprintf(result + pos, "%d)", nums[numsSize - 1]);

    return result;
}