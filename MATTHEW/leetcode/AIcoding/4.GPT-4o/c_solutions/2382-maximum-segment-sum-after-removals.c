int maximumSegmentSum(int* nums, int numsSize, int* removeQueries, int removeQueriesSize) {
    long long maxSum = 0, currentSum = 0;
    long long* segmentSums = (long long*)calloc(numsSize, sizeof(long long));
    int* parent = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        parent[i] = i;
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSets(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootY] = rootX;
            segmentSums[rootX] += segmentSums[rootY];
        }
    }

    for (int i = 0; i < numsSize; i++) {
        segmentSums[i] = nums[i];
    }

    for (int i = 0; i < removeQueriesSize; i++) {
        int index = removeQueries[i];
        segmentSums[index] = 0;

        if (index > 0 && segmentSums[index - 1] > 0) {
            unionSets(index, index - 1);
        }
        if (index < numsSize - 1 && segmentSums[index + 1] > 0) {
            unionSets(index, index + 1);
        }

        currentSum = 0;
        for (int j = 0; j < numsSize; j++) {
            if (segmentSums[j] > 0 && find(j) == j) {
                currentSum = fmax(currentSum, segmentSums[j]);
            }
        }
        maxSum = fmax(maxSum, currentSum);
    }

    free(segmentSums);
    free(parent);
    return maxSum;
}