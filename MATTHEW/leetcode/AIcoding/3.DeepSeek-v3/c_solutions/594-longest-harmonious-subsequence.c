int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int findLHS(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    qsort(nums, numsSize, sizeof(int), cmp);

    int max = 0;
    int left = 0;
    int right = 0;

    while (right < numsSize) {
        while (nums[right] - nums[left] > 1) {
            left++;
        }
        if (nums[right] - nums[left] == 1) {
            if (right - left + 1 > max) {
                max = right - left + 1;
            }
        }
        right++;
    }

    return max;
}