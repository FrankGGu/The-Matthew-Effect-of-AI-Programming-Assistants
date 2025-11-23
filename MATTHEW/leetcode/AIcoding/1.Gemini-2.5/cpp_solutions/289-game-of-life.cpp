class Solution {
public:
    void gameOfLife(std::vector<std::vector<int>>& board) {
        int m = board.size();
        if (m == 0) return;
        int n = board[0].size();
        if (n == 0) return;

        int dx[] = {-1, -1, -1, 0, 0, 1, 1, 1};
        int dy[] = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int live_neighbors = 0;

                for (int k = 0; k < 8; ++k) {
                    int ni = i + dx[k];
                    int nj = j + dy[k];

                    if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                        if (board[ni][nj] == 1 || board[ni][nj] == 3) {
                            live_neighbors++;
                        }
                    }
                }

                if (board[i][j] == 1) { // Current cell is live
                    if (live_neighbors < 2 || live_neighbors > 3) {
                        board[i][j] = 3; // Live -> Dead (encoded as 3)
                    }
                    // Else (live_neighbors == 2 or 3), it stays 1 (Live -> Live)
                } else { // Current cell is dead (board[i][j] == 0)
                    if (live_neighbors == 3) {
                        board[i][j] = 2; // Dead -> Live (encoded as 2)
                    }
                    // Else, it stays 0 (Dead -> Dead)
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (board[i][j] == 2) {
                    board[i][j] = 1; // Decode 2 to 1
                } else if (board[i][j] == 3) {
                    board[i][j] = 0; // Decode 3 to 0
                }
            }
        }
    }
};