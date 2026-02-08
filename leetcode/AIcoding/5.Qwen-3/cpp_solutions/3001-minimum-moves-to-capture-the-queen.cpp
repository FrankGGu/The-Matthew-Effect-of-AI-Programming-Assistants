#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minMovesToCaptureTheQueen(vector<vector<int>>& b, vector<int>& q, vector<int>& p) {
        int dx[] = {0, 1, 0, -1};
        int dy[] = {1, 0, -1, 0};
        int qx = q[0], qy = q[1];
        int px = p[0], py = p[1];

        for (int i = 0; i < 4; ++i) {
            int x = px + dx[i], y = py + dy[i];
            while (x >= 0 && x < 8 && y >= 0 && y < 8) {
                if (x == qx && y == qy) return 1;
                if (b[x][y] != 0) break;
                x += dx[i];
                y += dy[i];
            }
        }

        queue<pair<int, int>> qe;
        qe.push({px, py});
        vector<vector<bool>> visited(8, vector<bool>(8, false));
        visited[px][py] = true;

        int steps = 0;
        while (!qe.empty()) {
            int size = qe.size();
            for (int i = 0; i < size; ++i) {
                auto [x, y] = qe.front();
                qe.pop();
                if (x == qx && y == qy) return steps;
                for (int j = 0; j < 4; ++j) {
                    int nx = x + dx[j], ny = y + dy[j];
                    if (nx >= 0 && nx < 8 && ny >= 0 && ny < 8 && !visited[nx][ny] && b[nx][ny] == 0) {
                        visited[nx][ny] = true;
                        qe.push({nx, ny});
                    }
                }
            }
            ++steps;
        }
        return -1;
    }
};