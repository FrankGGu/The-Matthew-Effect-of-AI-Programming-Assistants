int countPairs(int* nums, int numsSize, int target) {
    int count = 0;
    qsort(nums, numsSize, sizeof(int), cmp);
    for (int i = 0; i < numsSize; i++) {
        int left = i + 1, right = numsSize - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (nums[i] + nums[mid] < target) {
                count += mid - left + 1;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
    }
    return count;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}