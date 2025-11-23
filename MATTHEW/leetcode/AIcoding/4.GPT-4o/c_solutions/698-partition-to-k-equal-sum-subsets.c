bool canPartitionKSubsets(int* nums, int numsSize, int k) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    if (sum % k != 0) return false;
    int target = sum / k;
    bool* visited = (bool*)malloc(numsSize * sizeof(bool));
    memset(visited, 0, numsSize * sizeof(bool));
    return backtrack(nums, numsSize, visited, 0, 0, k, target);
}

bool backtrack(int* nums, int numsSize, bool* visited, int startIndex, int currentSum, int k, int target) {
    if (k == 1) return true;
    if (currentSum == target) return backtrack(nums, numsSize, visited, 0, 0, k - 1, target);
    for (int i = startIndex; i < numsSize; i++) {
        if (!visited[i] && currentSum + nums[i] <= target) {
            visited[i] = true;
            if (backtrack(nums, numsSize, visited, i + 1, currentSum + nums[i], k, target)) {
                return true;
            }
            visited[i] = false;
        }
    }
    return false;
}