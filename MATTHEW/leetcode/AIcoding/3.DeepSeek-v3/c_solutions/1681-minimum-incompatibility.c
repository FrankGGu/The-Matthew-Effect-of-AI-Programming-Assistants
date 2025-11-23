int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int backtrack(int* nums, int numsSize, int k, int* subset, int subsetSize, int* visited, int idx, int* minSum) {
    if (idx == numsSize) {
        int sum = 0;
        for (int i = 0; i < k; i++) {
            int start = i * subsetSize;
            int end = start + subsetSize - 1;
            int minVal = nums[subset[start]];
            int maxVal = nums[subset[start]];
            for (int j = start + 1; j <= end; j++) {
                if (nums[subset[j]] < minVal) minVal = nums[subset[j]];
                if (nums[subset[j]] > maxVal) maxVal = nums[subset[j]];
            }
            sum += (maxVal - minVal);
        }
        if (sum < *minSum) *minSum = sum;
        return 1;
    }

    int found = 0;
    for (int i = 0; i < k; i++) {
        int start = i * subsetSize;
        int end = start + subsetSize - 1;
        int count = 0;
        for (int j = start; j <= end; j++) {
            if (subset[j] != -1) count++;
        }

        if (count == subsetSize) continue;

        if (count > 0) {
            int lastIndex = start + count - 1;
            if (nums[subset[lastIndex]] == nums[idx]) continue;
        }

        if (count > 0 && idx > 0 && nums[idx] == nums[idx - 1] && !visited[idx - 1]) continue;

        int valid = 1;
        for (int j = start; j < start + count; j++) {
            if (nums[subset[j]] == nums[idx]) {
                valid = 0;
                break;
            }
        }

        if (!valid) continue;

        subset[start + count] = idx;
        visited[idx] = 1;
        if (backtrack(nums, numsSize, k, subset, subsetSize, visited, idx + 1, minSum)) {
            found = 1;
        }
        subset[start + count] = -1;
        visited[idx] = 0;

        if (count == 0) break;
    }

    return found;
}

int minimumIncompatibility(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);

    int subsetSize = numsSize / k;
    int* subset = (int*)malloc(k * subsetSize * sizeof(int));
    int* visited = (int*)calloc(numsSize, sizeof(int));

    for (int i = 0; i < k * subsetSize; i++) {
        subset[i] = -1;
    }

    int minSum = INT_MAX;
    backtrack(nums, numsSize, k, subset, subsetSize, visited, 0, &minSum);

    free(subset);
    free(visited);

    return minSum == INT_MAX ? -1 : minSum;
}