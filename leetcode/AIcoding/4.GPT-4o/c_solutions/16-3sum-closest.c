int threeSumClosest(int* nums, int numsSize, int target) {
    int closest = nums[0] + nums[1] + nums[2];
    qsort(nums, numsSize, sizeof(int), cmp);

    for (int i = 0; i < numsSize - 2; i++) {
        int left = i + 1, right = numsSize - 1;
        while (left < right) {
            int sum = nums[i] + nums[left] + nums[right];
            if (sum == target) {
                return sum;
            }
            if (abs(sum - target) < abs(closest - target)) {
                closest = sum;
            }
            if (sum < target) {
                left++;
            } else {
                right--;
            }
        }
    }
    return closest;
}

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}