int minDifference(int* nums, int numsSize, int p) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int left = 0, right = nums[numsSize - 1] - nums[0], result = right;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (canFormPairs(nums, numsSize, p, mid)) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return result;
}

int canFormPairs(int* nums, int numsSize, int p, int mid) {
    int count = 0, i = 0;

    while (i < numsSize - 1) {
        if (nums[i + 1] - nums[i] <= mid) {
            count++;
            i += 2;
        } else {
            i++;
        }
    }
    return count >= p;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}