int cmp(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int findPairs(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int count = 0;
    int left = 0, right = 1;

    while (right < numsSize) {
        int diff = nums[right] - nums[left];

        if (diff < k) {
            right++;
        } else if (diff > k) {
            left++;
        } else {
            count++;
            left++;
            right++;
            while (right < numsSize && nums[right] == nums[right - 1]) {
                right++;
            }
        }

        if (left == right) {
            right++;
        }
    }

    return count;
}