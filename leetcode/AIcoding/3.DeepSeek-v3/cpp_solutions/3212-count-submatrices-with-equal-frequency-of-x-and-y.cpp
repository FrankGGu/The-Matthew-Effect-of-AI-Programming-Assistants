class Solution {
public:
    int countSubmatrices(vector<vector<int>>& grid, int x, int y) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        vector<vector<int>> prefix(m, vector<int>(n, 0));
        unordered_map<int, int> freq;
        int res = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int val = grid[i][j];
                if (i == 0 && j == 0) {
                    prefix[i][j] = val;
                } else if (i == 0) {
                    prefix[i][j] = prefix[i][j-1] + val;
                } else if (j == 0) {
                    prefix[i][j] = prefix[i-1][j] + val;
                } else {
                    prefix[i][j] = prefix[i-1][j] + prefix[i][j-1] - prefix[i-1][j-1] + val;
                }
                freq[prefix[i][j]]++;
            }
        }

        int totalX = 0, totalY = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == x) totalX++;
                if (grid[i][j] == y) totalY++;
            }
        }

        if (totalX == 0 && totalY == 0) {
            return m * n;
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int sum = prefix[i][j];
                int target = sum - (totalX - totalY) * x;
                if (target % (y - x) != 0) continue;
                int k = target / (y - x);
                if (k >= 0 && k <= sum) {
                    res += freq[sum - k * (y - x)];
                }
            }
        }

        return res;
    }
};