#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> queensAttacktheKing(vector<vector<int>>& queens, vector<int>& king) {
        vector<vector<int>> result;
        vector<vector<bool>> board(8, vector<bool>(8, false));
        for (auto& queen : queens) {
            board[queen[0]][queen[1]] = true;
        }

        int dx[] = {-1, -1, -1, 0, 0, 1, 1, 1};
        int dy[] = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int i = 0; i < 8; ++i) {
            int x = king[0] + dx[i];
            int y = king[1] + dy[i];
            while (x >= 0 && x < 8 && y >= 0 && y < 8) {
                if (board[x][y]) {
                    result.push_back({x, y});
                    break;
                }
                x += dx[i];
                y += dy[i];
            }
        }

        return result;
    }
};