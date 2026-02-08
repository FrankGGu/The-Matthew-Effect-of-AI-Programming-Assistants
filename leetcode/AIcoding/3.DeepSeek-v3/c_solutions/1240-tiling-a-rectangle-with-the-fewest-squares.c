int minSquares;

void dfs(int* heights, int heightsSize, int cur, int n, int cnt) {
    if (cnt >= minSquares) return;

    if (cur == n) {
        minSquares = cnt;
        return;
    }

    int minHeight = n;
    int start = -1;
    for (int i = 0; i < heightsSize; i++) {
        if (heights[i] < minHeight) {
            minHeight = heights[i];
            start = i;
        }
    }

    if (minHeight == n) return;

    int end = start;
    while (end < heightsSize && heights[end] == minHeight && (end - start + 1) + minHeight <= n) {
        end++;
    }
    end--;

    for (int len = end - start + 1; len >= 1; len--) {
        for (int j = start; j < start + len; j++) {
            heights[j] += len;
        }
        dfs(heights, heightsSize, cur + len * len, n, cnt + 1);
        for (int j = start; j < start + len; j++) {
            heights[j] -= len;
        }
    }
}

int tilingRectangle(int n, int m) {
    if (n == m) return 1;
    if (n > m) {
        int temp = n;
        n = m;
        m = temp;
    }

    minSquares = n * m;
    int* heights = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        heights[i] = 0;
    }

    dfs(heights, m, 0, n, 0);
    free(heights);
    return minSquares;
}