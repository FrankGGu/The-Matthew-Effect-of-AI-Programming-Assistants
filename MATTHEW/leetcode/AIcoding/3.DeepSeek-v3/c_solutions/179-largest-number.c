int compare(const void* a, const void* b) {
    char str1[24], str2[24];
    sprintf(str1, "%d%d", *(int*)a, *(int*)b);
    sprintf(str2, "%d%d", *(int*)b, *(int*)a);
    return strcmp(str2, str1);
}

char* largestNumber(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    if (nums[0] == 0) {
        char* result = malloc(2);
        result[0] = '0';
        result[1] = '\0';
        return result;
    }

    int totalLength = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        do {
            totalLength++;
            num /= 10;
        } while (num > 0);
    }

    char* result = malloc(totalLength + 1);
    int pos = 0;
    for (int i = 0; i < numsSize; i++) {
        pos += sprintf(result + pos, "%d", nums[i]);
    }
    result[totalLength] = '\0';

    return result;
}