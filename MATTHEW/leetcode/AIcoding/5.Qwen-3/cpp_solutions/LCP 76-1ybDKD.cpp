#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int magicalBoard(int n, int m, vector<vector<int>>& board) {
        vector<vector<int>> visited(n, vector<int>(m, 0));
        queue<pair<int, int>> q;
        q.push({0, 0});
        visited[0][0] = 1;
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [x, y] = q.front();
                q.pop();

                if (x == n - 1 && y == m - 1) {
                    return steps;
                }

                int val = board[x][y];
                int dx[] = {0, 1, -1, 0};
                int dy[] = {1, 0, 0, -1};

                for (int k = 0; k < 4; ++k) {
                    int nx = x + dx[k] * val;
                    int ny = y + dy[k] * val;

                    if (nx >= 0 && nx < n && ny >= 0 && ny < m && !visited[nx][ny]) {
                        visited[nx][ny] = 1;
                        q.push({nx, ny});
                    }
                }
            }
            ++steps;
        }

        return -1;
    }
};