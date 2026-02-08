int maxNumOfMarkedIndices(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    int left = 0, right = numsSize / 2;
    while (right < numsSize && left < numsSize / 2) {
        if (2 * nums[left] <= nums[right]) {
            left++;
        }
        right++;
    }
    return left * 2;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}