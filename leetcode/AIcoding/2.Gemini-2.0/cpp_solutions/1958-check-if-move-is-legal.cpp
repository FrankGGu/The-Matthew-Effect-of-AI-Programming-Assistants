class Solution {
public:
    bool checkMove(vector<string>& board, int rMove, int cMove, char color) {
        int n = board.size();
        int m = board[0].size();
        char opponent = (color == 'B') ? 'W' : 'B';

        int dx[] = {0, 0, 1, -1, 1, 1, -1, -1};
        int dy[] = {1, -1, 0, 0, 1, -1, 1, -1};

        for (int i = 0; i < 8; ++i) {
            int x = rMove + dx[i];
            int y = cMove + dy[i];
            int count = 0;

            while (x >= 0 && x < n && y >= 0 && y < m) {
                if (board[x][y] == opponent) {
                    count++;
                } else if (board[x][y] == color) {
                    if (count >= 1) {
                        return true;
                    } else {
                        break;
                    }
                } else {
                    break;
                }
                x += dx[i];
                y += dy[i];
            }
        }

        return false;
    }
};