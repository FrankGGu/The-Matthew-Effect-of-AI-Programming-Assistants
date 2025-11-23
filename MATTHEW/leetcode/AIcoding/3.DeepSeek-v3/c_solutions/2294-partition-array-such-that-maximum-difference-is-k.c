int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int partitionArray(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int count = 1;
    int start = nums[0];

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] - start > k) {
            count++;
            start = nums[i];
        }
    }

    return count;
}