class Solution {
public:
    bool checkMove(vector<vector<char>>& board, int rMove, int cMove, char color) {
        int directions[5] = {0, 1, 1, 0, -1};
        for (int i = 0; i < 4; ++i) {
            int r = rMove + directions[i];
            int c = cMove + directions[i + 1];
            int count = 0;
            while (r >= 0 && r < 8 && c >= 0 && c < 8 && board[r][c] != '.') {
                if (board[r][c] == color) {
                    if (count > 0) return true;
                    break;
                }
                count++;
                r += directions[i];
                c += directions[i + 1];
            }
        }
        return false;
    }
};