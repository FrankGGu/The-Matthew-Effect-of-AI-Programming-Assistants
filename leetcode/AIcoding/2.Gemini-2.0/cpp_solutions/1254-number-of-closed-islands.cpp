class Solution {
public:
    int closedIsland(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        int count = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    bool isClosed = true;
                    queue<pair<int, int>> q;
                    q.push({i, j});
                    grid[i][j] = 1;

                    while (!q.empty()) {
                        int row = q.front().first;
                        int col = q.front().second;
                        q.pop();

                        if (row == 0 || row == m - 1 || col == 0 || col == n - 1) {
                            isClosed = false;
                        }

                        int dr[] = {0, 0, 1, -1};
                        int dc[] = {1, -1, 0, 0};

                        for (int k = 0; k < 4; ++k) {
                            int newRow = row + dr[k];
                            int newCol = col + dc[k];

                            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && grid[newRow][newCol] == 0) {
                                q.push({newRow, newCol});
                                grid[newRow][newCol] = 1;
                            }
                        }
                    }

                    if (isClosed) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
};