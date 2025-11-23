int numSubarrayBoundedMax(int* nums, int numsSize, int left, int right) {
    int count = 0;
    int start = -1;
    int end = -1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > right) {
            start = i;
        }
        if (nums[i] >= left) {
            end = i;
        }
        count += end - start;
    }

    return count;
}