class Solution {
public:
    vector<int> findBall(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<int> result(n);

        for (int ball = 0; ball < n; ++ball) {
            int col = ball;
            for (int row = 0; row < m; ++row) {
                int next_col = col + grid[row][col];
                if (next_col < 0 || next_col >= n || grid[row][col] != grid[row][next_col]) {
                    col = -1;
                    break;
                }
                col = next_col;
            }
            result[ball] = col;
        }

        return result;
    }
};