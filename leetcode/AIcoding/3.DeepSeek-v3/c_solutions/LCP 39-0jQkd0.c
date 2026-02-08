int minimumSwitchingTimes(int** source, int sourceSize, int* sourceColSize, int** target, int targetSize, int* targetColSize) {
    int count[10001] = {0};
    int n = sourceSize, m = sourceColSize[0];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            count[source[i][j]]++;
            count[target[i][j]]--;
        }
    }
    int ans = 0;
    for (int i = 0; i < 10001; i++) {
        if (count[i] > 0) {
            ans += count[i];
        }
    }
    return ans;
}