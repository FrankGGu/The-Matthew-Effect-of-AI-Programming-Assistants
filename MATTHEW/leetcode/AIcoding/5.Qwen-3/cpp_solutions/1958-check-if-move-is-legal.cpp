#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool isLegalMove(vector<vector<int>>& chessboard, int x, int y, int player) {
        if (x < 0 || x >= chessboard.size() || y < 0 || y >= chessboard[0].size()) {
            return false;
        }
        if (chessboard[x][y] != 0) {
            return false;
        }
        int dx[] = {-1, -1, -1, 0, 0, 1, 1, 1};
        int dy[] = {-1, 0, 1, -1, 1, -1, 0, 1};
        for (int i = 0; i < 8; ++i) {
            int nx = x + dx[i];
            int ny = y + dy[i];
            bool foundOpponent = false;
            while (nx >= 0 && nx < chessboard.size() && ny >= 0 && ny < chessboard[0].size()) {
                if (chessboard[nx][ny] == 0) {
                    break;
                }
                if (chessboard[nx][ny] == player) {
                    if (foundOpponent) {
                        return true;
                    } else {
                        break;
                    }
                }
                foundOpponent = true;
                nx += dx[i];
                ny += dy[i];
            }
        }
        return false;
    }
};