int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

bool backtrack(int* nums, int numsSize, int k, int target, int current, int start, int* used, int subsetCount) {
    if (subsetCount == k - 1) return true;
    if (current == target) {
        return backtrack(nums, numsSize, k, target, 0, 0, used, subsetCount + 1);
    }

    for (int i = start; i < numsSize; i++) {
        if (used[i] || current + nums[i] > target) continue;
        used[i] = 1;
        if (backtrack(nums, numsSize, k, target, current + nums[i], i + 1, used, subsetCount)) {
            return true;
        }
        used[i] = 0;

        while (i + 1 < numsSize && nums[i] == nums[i + 1]) i++;
        if (current == 0) return false;
    }
    return false;
}

bool canPartitionKSubsets(int* nums, int numsSize, int k) {
    if (k == 1) return true;
    if (numsSize < k) return false;

    int sum = 0;
    for (int i = 0; i < numsSize; i++) sum += nums[i];
    if (sum % k != 0) return false;

    int target = sum / k;
    qsort(nums, numsSize, sizeof(int), cmp);

    if (nums[0] > target) return false;

    int* used = (int*)calloc(numsSize, sizeof(int));
    bool result = backtrack(nums, numsSize, k, target, 0, 0, used, 0);
    free(used);
    return result;
}