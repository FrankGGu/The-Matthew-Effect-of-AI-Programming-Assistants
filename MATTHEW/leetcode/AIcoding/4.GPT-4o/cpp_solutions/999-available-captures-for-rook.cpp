class Solution {
public:
    int numRookCaptures(vector<vector<char>>& board) {
        int count = 0;
        int n = board.size(), m = board[0].size();
        int rookRow, rookCol;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (board[i][j] == 'R') {
                    rookRow = i;
                    rookCol = j;
                    break;
                }
            }
        }

        int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        for (auto& dir : directions) {
            int x = rookRow, y = rookCol;
            while (true) {
                x += dir[0];
                y += dir[1];
                if (x < 0 || x >= n || y < 0 || y >= m) break;
                if (board[x][y] == 'B') break;
                if (board[x][y] == 'p') {
                    count++;
                    break;
                }
            }
        }

        return count;
    }
};