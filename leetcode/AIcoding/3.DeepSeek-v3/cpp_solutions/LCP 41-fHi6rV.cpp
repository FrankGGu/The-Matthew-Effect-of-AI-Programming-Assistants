class Solution {
public:
    vector<vector<char>> flipChess(vector<string>& chessboard) {
        int m = chessboard.size();
        int n = chessboard[0].size();
        vector<vector<char>> board(m, vector<char>(n));
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                board[i][j] = chessboard[i][j];
            }
        }

        int max_flips = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (board[i][j] == '.') {
                    vector<vector<char>> temp = board;
                    temp[i][j] = 'X';
                    int flips = simulate(temp, i, j, m, n);
                    if (flips > max_flips) {
                        max_flips = flips;
                    }
                }
            }
        }
        return max_flips;
    }

    int simulate(vector<vector<char>>& board, int x, int y, int m, int n) {
        int flips = 0;
        queue<pair<int, int>> q;
        q.push({x, y});
        int dirs[8][2] = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};

        while (!q.empty()) {
            auto pos = q.front();
            q.pop();
            int i = pos.first;
            int j = pos.second;

            for (auto& dir : dirs) {
                int ni = i + dir[0];
                int nj = j + dir[1];
                if (ni < 0 || ni >= m || nj < 0 || nj >= n || board[ni][nj] != 'O') {
                    continue;
                }

                vector<pair<int, int>> path;
                path.push_back({ni, nj});
                bool found = false;
                while (true) {
                    ni += dir[0];
                    nj += dir[1];
                    if (ni < 0 || ni >= m || nj < 0 || nj >= n) {
                        break;
                    }
                    if (board[ni][nj] == 'X') {
                        found = true;
                        break;
                    } else if (board[ni][nj] == '.') {
                        break;
                    }
                    path.push_back({ni, nj});
                }

                if (found) {
                    for (auto& p : path) {
                        board[p.first][p.second] = 'X';
                        q.push(p);
                        flips++;
                    }
                }
            }
        }
        return flips;
    }
};