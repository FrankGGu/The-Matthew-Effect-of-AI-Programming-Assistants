class Solution {
public:
    bool canPartition(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return false;
        int n = grid[0].size();
        if (n == 0) return false;

        int totalSum = 0;
        vector<int> rowSums(m, 0);
        vector<int> colSums(n, 0);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                rowSums[i] += grid[i][j];
                colSums[j] += grid[i][j];
                totalSum += grid[i][j];
            }
        }

        if (totalSum % 2 != 0) return false;
        int target = totalSum / 2;

        for (int i = 0; i < m - 1; ++i) {
            int sum = 0;
            for (int k = 0; k <= i; ++k) {
                sum += rowSums[k];
            }
            if (sum == target) return true;
        }

        for (int j = 0; j < n - 1; ++j) {
            int sum = 0;
            for (int k = 0; k <= j; ++k) {
                sum += colSums[k];
            }
            if (sum == target) return true;
        }

        return false;
    }
};