class Solution {
public:
    int minimumOperationsToWriteY(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<int> yCount(3, 0), nonYCount(3, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                bool isY = false;
                if (i == j && i <= n / 2) isY = true;
                if (i + j == n - 1 && i <= n / 2) isY = true;
                if (i >= n / 2 && j == n / 2) isY = true;

                if (isY) {
                    yCount[grid[i][j]]++;
                } else {
                    nonYCount[grid[i][j]]++;
                }
            }
        }

        int minOps = INT_MAX;
        for (int yVal = 0; yVal < 3; ++yVal) {
            for (int nonYVal = 0; nonYVal < 3; ++nonYVal) {
                if (yVal == nonYVal) continue;
                int ops = 0;
                for (int k = 0; k < 3; ++k) {
                    if (k != yVal) ops += yCount[k];
                    if (k != nonYVal) ops += nonYCount[k];
                }
                if (ops < minOps) minOps = ops;
            }
        }

        return minOps;
    }
};