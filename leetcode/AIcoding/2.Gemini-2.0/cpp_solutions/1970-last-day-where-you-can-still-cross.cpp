#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int latestDayToCross(int row, int col, vector<vector<int>>& cells) {
        int left = 0, right = cells.size() - 1;
        int ans = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            vector<vector<int>> grid(row, vector<int>(col, 0));

            for (int i = 0; i <= mid; ++i) {
                grid[cells[i][0] - 1][cells[i][1] - 1] = 1;
            }

            if (canCross(grid)) {
                ans = mid + 1;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return ans;
    }

private:
    bool canCross(vector<vector<int>>& grid) {
        int row = grid.size();
        int col = grid[0].size();
        vector<vector<bool>> visited(row, vector<bool>(col, false));
        queue<pair<int, int>> q;

        for (int j = 0; j < col; ++j) {
            if (grid[0][j] == 0) {
                q.push({0, j});
                visited[0][j] = true;
            }
        }

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        while (!q.empty()) {
            int x = q.front().first;
            int y = q.front().second;
            q.pop();

            if (x == row - 1) {
                return true;
            }

            for (int i = 0; i < 4; ++i) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                if (nx >= 0 && nx < row && ny >= 0 && ny < col && grid[nx][ny] == 0 && !visited[nx][ny]) {
                    q.push({nx, ny});
                    visited[nx][ny] = true;
                }
            }
        }

        return false;
    }
};