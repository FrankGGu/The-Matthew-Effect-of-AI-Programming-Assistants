class Solution {
public:
    bool checkValidGrid(vector<vector<int>>& grid) {
        int n = grid.size();
        if (n == 0 || grid[0].size() != n) return false;

        vector<pair<int, int>> moves = {{2, 1}, {1, 2}, {-1, 2}, {-2, 1}, 
                                         {-2, -1}, {-1, -2}, {1, -2}, {2, -1}};
        vector<vector<bool>> visited(n, vector<bool>(n, false));

        int currX = 0, currY = 0;
        visited[0][0] = true;

        for (int i = 1; i < n * n; ++i) {
            int x = -1, y = -1;
            for (const auto& move : moves) {
                int newX = currX + move.first;
                int newY = currY + move.second;
                if (newX >= 0 && newX < n && newY >= 0 && newY < n && 
                    grid[newX][newY] == i && !visited[newX][newY]) {
                    x = newX;
                    y = newY;
                    break;
                }
            }
            if (x == -1) return false;
            visited[x][y] = true;
            currX = x;
            currY = y;
        }

        return true;
    }
};