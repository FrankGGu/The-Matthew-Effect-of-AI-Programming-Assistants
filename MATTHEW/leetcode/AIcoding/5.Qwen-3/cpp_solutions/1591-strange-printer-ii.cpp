#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool isPrintable(vector<vector<int>>& rect) {
        int m = rect.size();
        int n = rect[0].size();

        vector<vector<int>> colorToRect(101, vector<int>(4, 0));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int c = rect[i][j];
                if (colorToRect[c][0] > i) colorToRect[c][0] = i;
                if (colorToRect[c][1] < i) colorToRect[c][1] = i;
                if (colorToRect[c][2] > j) colorToRect[c][2] = j;
                if (colorToRect[c][3] < j) colorToRect[c][3] = j;
            }
        }

        vector<vector<bool>> visited(m, vector<bool>(n, false));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (!visited[i][j]) {
                    int c = rect[i][j];
                    int top = colorToRect[c][0];
                    int bottom = colorToRect[c][1];
                    int left = colorToRect[c][2];
                    int right = colorToRect[c][3];

                    queue<pair<int, int>> q;
                    q.push({i, j});
                    visited[i][j] = true;

                    while (!q.empty()) {
                        auto [x, y] = q.front();
                        q.pop();

                        for (int dx = -1; dx <= 1; ++dx) {
                            for (int dy = -1; dy <= 1; ++dy) {
                                int nx = x + dx;
                                int ny = y + dy;
                                if (nx >= top && nx <= bottom && ny >= left && ny <= right &&
                                    !visited[nx][ny] && rect[nx][ny] == c) {
                                    visited[nx][ny] = true;
                                    q.push({nx, ny});
                                }
                            }
                        }
                    }
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (!visited[i][j]) return false;
            }
        }

        return true;
    }
};