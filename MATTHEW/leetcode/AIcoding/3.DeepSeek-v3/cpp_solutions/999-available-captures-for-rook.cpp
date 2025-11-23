class Solution {
public:
    int numRookCaptures(vector<vector<char>>& board) {
        int x, y;
        for (int i = 0; i < 8; ++i) {
            for (int j = 0; j < 8; ++j) {
                if (board[i][j] == 'R') {
                    x = i;
                    y = j;
                    break;
                }
            }
        }

        int res = 0;
        int dx[] = {-1, 1, 0, 0};
        int dy[] = {0, 0, -1, 1};

        for (int i = 0; i < 4; ++i) {
            int nx = x + dx[i];
            int ny = y + dy[i];
            while (nx >= 0 && nx < 8 && ny >= 0 && ny < 8) {
                if (board[nx][ny] == 'p') {
                    res++;
                    break;
                } else if (board[nx][ny] == 'B') {
                    break;
                }
                nx += dx[i];
                ny += dy[i];
            }
        }
        return res;
    }
};