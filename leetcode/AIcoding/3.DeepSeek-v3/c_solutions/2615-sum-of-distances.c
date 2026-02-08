/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
long long* distance(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    long long* res = (long long*)calloc(numsSize, sizeof(long long));

    // Group indices by value
    int** groups = (int**)malloc(numsSize * sizeof(int*));
    int* groupSizes = (int*)calloc(numsSize, sizeof(int));
    int* groupCapacity = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        groups[i] = (int*)malloc(10 * sizeof(int));
        groupCapacity[i] = 10;
    }

    for (int i = 0; i < numsSize; i++) {
        int val = nums[i];
        if (groupSizes[val] >= groupCapacity[val]) {
            groupCapacity[val] *= 2;
            groups[val] = (int*)realloc(groups[val], groupCapacity[val] * sizeof(int));
        }
        groups[val][groupSizes[val]++] = i;
    }

    // Calculate distances for each group
    for (int val = 0; val < numsSize; val++) {
        int size = groupSizes[val];
        if (size == 0) continue;

        long long* prefix = (long long*)malloc(size * sizeof(long long));
        prefix[0] = groups[val][0];
        for (int i = 1; i < size; i++) {
            prefix[i] = prefix[i-1] + groups[val][i];
        }

        for (int i = 0; i < size; i++) {
            int idx = groups[val][i];
            long long left = (long long)i * idx - (i > 0 ? prefix[i-1] : 0);
            long long right = (prefix[size-1] - prefix[i]) - (long long)(size - 1 - i) * idx;
            res[idx] = left + right;
        }

        free(prefix);
    }

    // Cleanup
    for (int i = 0; i < numsSize; i++) {
        free(groups[i]);
    }
    free(groups);
    free(groupSizes);
    free(groupCapacity);

    return res;
}