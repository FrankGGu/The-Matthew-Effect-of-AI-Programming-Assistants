int triangleNumber(int* nums, int numsSize) {
    int count = 0;
    qsort(nums, numsSize, sizeof(int), cmp);
    for (int i = 0; i < numsSize - 2; i++) {
        for (int j = i + 1; j < numsSize - 1; j++) {
            for (int k = j + 1; k < numsSize; k++) {
                if (nums[i] + nums[j] > nums[k]) {
                    count++;
                } else {
                    break;
                }
            }
        }
    }
    return count;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}