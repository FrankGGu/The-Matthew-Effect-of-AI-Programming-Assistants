#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> removeBubbles(vector<vector<int>>& board, int row, int col, int color) {
        if (row < 0 || row >= board.size() || col < 0 || col >= board[0].size() || board[row][col] != color) {
            return board;
        }

        int rows = board.size();
        int cols = board[0].size();
        vector<pair<int, int>> visited;
        queue<pair<int, int>> q;

        q.push({row, col});
        visited.push_back({row, col});
        board[row][col] = -1;

        while (!q.empty()) {
            pair<int, int> curr = q.front();
            q.pop();

            int r = curr.first;
            int c = curr.second;

            int dr[] = {-1, -1, 0, 0, 1, 1};
            int dc[] = {-1, 0, -1, 1, 0, -1};

            for (int i = 0; i < 6; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && board[nr][nc] == color) {
                    bool seen = false;
                    for (auto p : visited) {
                        if (p.first == nr && p.second == nc) {
                            seen = true;
                            break;
                        }
                    }
                    if (!seen) {
                        q.push({nr, nc});
                        visited.push_back({nr, nc});
                        board[nr][nc] = -1;
                    }
                }
            }
        }

        return board;
    }
};