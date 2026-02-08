int maxOperations(int* nums, int numsSize, int k) {
    int count = 0;
    int left = 0, right = numsSize - 1;

    qsort(nums, numsSize, sizeof(int), cmpfunc);

    while (left < right) {
        int sum = nums[left] + nums[right];
        if (sum == k) {
            count++;
            left++;
            right--;
        } else if (sum < k) {
            left++;
        } else {
            right--;
        }
    }

    return count;
}

int cmpfunc(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}