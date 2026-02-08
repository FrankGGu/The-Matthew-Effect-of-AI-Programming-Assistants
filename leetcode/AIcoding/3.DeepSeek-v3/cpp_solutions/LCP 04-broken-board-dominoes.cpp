class Solution {
public:
    int domino(int n, int m, vector<vector<int>>& broken) {
        vector<vector<int>> board(n, vector<int>(m, 0));
        for (auto& b : broken) {
            board[b[0]][b[1]] = -1;
        }

        vector<int> match(n * m, -1);
        vector<vector<int>> dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        function<bool(int, vector<bool>&)> dfs = [&](int u, vector<bool>& visited) {
            int x = u / m, y = u % m;
            for (auto& dir : dirs) {
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && nx < n && ny >= 0 && ny < m && board[nx][ny] != -1) {
                    int v = nx * m + ny;
                    if (!visited[v]) {
                        visited[v] = true;
                        if (match[v] == -1 || dfs(match[v], visited)) {
                            match[u] = v;
                            match[v] = u;
                            return true;
                        }
                    }
                }
            }
            return false;
        };

        int res = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if ((i + j) % 2 == 0 && board[i][j] != -1) {
                    int u = i * m + j;
                    if (match[u] == -1) {
                        vector<bool> visited(n * m, false);
                        if (dfs(u, visited)) {
                            res++;
                        }
                    }
                }
            }
        }
        return res;
    }
};