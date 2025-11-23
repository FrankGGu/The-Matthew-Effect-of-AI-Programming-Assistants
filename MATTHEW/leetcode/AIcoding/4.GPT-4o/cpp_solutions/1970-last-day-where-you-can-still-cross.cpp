class Solution {
public:
    int latestDayToCross(int row, int col, vector<vector<int>>& cells) {
        int left = 1, right = cells.size(), result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            vector<vector<int>> grid(row, vector<int>(col, 0));
            for (int i = 0; i < mid; ++i) {
                grid[cells[i][0] - 1][cells[i][1] - 1] = 1;
            }
            if (canCross(grid, row, col)) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }

private:
    bool canCross(vector<vector<int>>& grid, int row, int col) {
        vector<vector<bool>> visited(row, vector<bool>(col, false));
        queue<int> q;
        for (int j = 0; j < col; ++j) {
            if (grid[0][j] == 0) {
                q.push(j);
                visited[0][j] = true;
            }
        }

        while (!q.empty()) {
            int j = q.front();
            q.pop();
            if (j < 0 || j >= col) continue;
            if (grid[row - 1][j] == 0) return true;
            for (int d : {-1, 0, 1}) {
                int ni = 1, nj = j + d;
                if (nj >= 0 && nj < col && !visited[ni][nj] && grid[ni][nj] == 0) {
                    visited[ni][nj] = true;
                    q.push(nj);
                }
            }
        }

        return false;
    }
};