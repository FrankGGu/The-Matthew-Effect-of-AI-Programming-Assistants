int longestVShapedDiagonalSegment(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int maxLen = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 0) continue;

            int x = i, y = j;
            int len1 = 0, len2 = 0;

            while (x > 0 && y > 0 && grid[x-1][y-1] == 1) {
                x--;
                y--;
                len1++;
            }

            x = i;
            y = j;
            while (x > 0 && y < n-1 && grid[x-1][y+1] == 1) {
                x--;
                y++;
                len2++;
            }

            if (len1 > 0 && len2 > 0) {
                int current = 1 + 2 * (len1 < len2 ? len1 : len2);
                if (current > maxLen) {
                    maxLen = current;
                }
            }
        }
    }

    return maxLen;
}