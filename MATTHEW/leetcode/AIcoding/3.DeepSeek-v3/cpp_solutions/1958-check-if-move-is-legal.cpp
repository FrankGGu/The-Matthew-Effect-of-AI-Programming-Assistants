class Solution {
public:
    bool checkMove(vector<vector<char>>& board, int rMove, int cMove, char color) {
        int directions[8][2] = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};
        board[rMove][cMove] = color;

        for (auto& dir : directions) {
            int x = rMove + dir[0];
            int y = cMove + dir[1];
            int count = 0;

            while (x >= 0 && x < 8 && y >= 0 && y < 8) {
                if (board[x][y] == '.') break;
                if (board[x][y] == color) {
                    if (count >= 1) return true;
                    break;
                }
                count++;
                x += dir[0];
                y += dir[1];
            }
        }

        return false;
    }
};