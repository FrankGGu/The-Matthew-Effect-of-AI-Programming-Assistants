class Solution {
public:
    vector<int> findBall(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<int> result(n, -1);

        for (int j = 0; j < n; j++) {
            int col = j;
            for (int i = 0; i < m; i++) {
                if (grid[i][col] == 1) {
                    if (col == n - 1 || grid[i][col + 1] == -1) {
                        col = -1;
                        break;
                    }
                    col++;
                } else {
                    if (col == 0 || grid[i][col - 1] == 1) {
                        col = -1;
                        break;
                    }
                    col--;
                }
            }
            result[j] = col;
        }

        return result;
    }
};