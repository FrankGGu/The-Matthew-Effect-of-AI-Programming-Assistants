int minOperations(int** grid, int gridSize, int* gridColSize) {
    int total = 0, n = gridSize * gridColSize[0], minOps = INT_MAX;
    int count[101] = {0}, freq[101] = {0};

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            count[grid[i][j]]++;
            total++;
        }
    }

    for (int val = 0; val <= 100; val++) {
        if (count[val] > 0) {
            freq[val] = total - count[val];
            minOps = minOps < freq[val] ? minOps : freq[val];
        }
    }

    return minOps;
}