class Solution {
public:
    vector<vector<int>> queensAttacktheKing(vector<vector<int>>& queens, vector<int>& king) {
        vector<vector<int>> res;
        bool board[8][8] = {false};
        for (auto& q : queens) {
            board[q[0]][q[1]] = true;
        }
        int x = king[0], y = king[1];
        for (int dx = -1; dx <= 1; ++dx) {
            for (int dy = -1; dy <= 1; ++dy) {
                if (dx == 0 && dy == 0) continue;
                int nx = x + dx, ny = y + dy;
                while (nx >= 0 && nx < 8 && ny >= 0 && ny < 8) {
                    if (board[nx][ny]) {
                        res.push_back({nx, ny});
                        break;
                    }
                    nx += dx;
                    ny += dy;
                }
            }
        }
        return res;
    }
};