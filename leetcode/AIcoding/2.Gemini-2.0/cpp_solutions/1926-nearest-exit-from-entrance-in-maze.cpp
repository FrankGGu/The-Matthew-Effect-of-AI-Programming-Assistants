#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int nearestExit(vector<vector<char>>& maze, vector<int>& entrance) {
        int m = maze.size();
        int n = maze[0].size();
        queue<pair<int, int>> q;
        q.push({entrance[0], entrance[1]});
        maze[entrance[0]][entrance[1]] = '+';
        int steps = 0;
        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int x = q.front().first;
                int y = q.front().second;
                q.pop();

                for (int j = 0; j < 4; ++j) {
                    int nx = x + dx[j];
                    int ny = y + dy[j];

                    if (nx >= 0 && nx < m && ny >= 0 && ny < n && maze[nx][ny] == '.') {
                        if (nx == 0 || nx == m - 1 || ny == 0 || ny == n - 1) {
                            return steps + 1;
                        }
                        maze[nx][ny] = '+';
                        q.push({nx, ny});
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};