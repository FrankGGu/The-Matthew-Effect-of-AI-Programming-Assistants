int maxElements(int* nums, int numsSize, int limit) {
    int count = 0, sum = 0;
    qsort(nums, numsSize, sizeof(int), cmp);
    for (int i = 0; i < numsSize; i++) {
        if (sum + nums[i] <= limit) {
            sum += nums[i];
            count++;
        } else {
            break;
        }
    }
    return count;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}