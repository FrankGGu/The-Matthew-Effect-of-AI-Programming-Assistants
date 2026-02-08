int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

bool dfs(int* nums, int numsSize, int index, long long product1, long long product2, long long total) {
    if (index == numsSize) {
        return product1 == product2;
    }

    if (product1 > total / 2 || product2 > total / 2) {
        return false;
    }

    if (dfs(nums, numsSize, index + 1, product1 * nums[index], product2, total)) {
        return true;
    }

    if (dfs(nums, numsSize, index + 1, product1, product2 * nums[index], total)) {
        return true;
    }

    return false;
}

bool canPartition(int* nums, int numsSize) {
    long long total = 1;
    for (int i = 0; i < numsSize; i++) {
        total *= nums[i];
    }

    qsort(nums, numsSize, sizeof(int), cmp);

    return dfs(nums, numsSize, 0, 1, 1, total);
}