#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    vector<vector<int>> dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    bool hasPath(vector<vector<int>>& maze, vector<int>& start, vector<int>& destination) {
        int m = maze.size();
        if (m == 0) return false;
        int n = maze[0].size();
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        queue<vector<int>> q;
        q.push(start);
        visited[start[0]][start[1]] = true;

        while (!q.empty()) {
            vector<int> curr = q.front();
            q.pop();
            if (curr[0] == destination[0] && curr[1] == destination[1]) {
                return true;
            }
            for (auto& dir : dirs) {
                int x = curr[0] + dir[0];
                int y = curr[1] + dir[1];
                while (x >= 0 && y >= 0 && x < m && y < n && maze[x][y] == 0) {
                    x += dir[0];
                    y += dir[1];
                }
                x -= dir[0];
                y -= dir[1];
                if (!visited[x][y]) {
                    visited[x][y] = true;
                    q.push({x, y});
                }
            }
        }
        return false;
    }
};