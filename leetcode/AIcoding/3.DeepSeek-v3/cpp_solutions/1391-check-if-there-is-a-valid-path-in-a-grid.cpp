class Solution {
public:
    bool hasValidPath(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return false;
        int n = grid[0].size();
        if (n == 0) return false;

        vector<vector<bool>> visited(m, vector<bool>(n, false));
        queue<pair<int, int>> q;
        q.push({0, 0});
        visited[0][0] = true;

        vector<vector<pair<int, int>>> dirs = {
            {{0, -1}, {0, 1}},
            {{-1, 0}, {1, 0}},
            {{0, -1}, {1, 0}},
            {{0, 1}, {1, 0}},
            {{0, -1}, {-1, 0}},
            {{0, 1}, {-1, 0}}
        };

        while (!q.empty()) {
            auto curr = q.front();
            q.pop();
            int i = curr.first;
            int j = curr.second;
            if (i == m - 1 && j == n - 1) {
                return true;
            }
            for (auto dir : dirs[grid[i][j] - 1]) {
                int ni = i + dir.first;
                int nj = j + dir.second;
                if (ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj]) {
                    for (auto backDir : dirs[grid[ni][nj] - 1]) {
                        if (ni + backDir.first == i && nj + backDir.second == j) {
                            visited[ni][nj] = true;
                            q.push({ni, nj});
                            break;
                        }
                    }
                }
            }
        }
        return false;
    }
};