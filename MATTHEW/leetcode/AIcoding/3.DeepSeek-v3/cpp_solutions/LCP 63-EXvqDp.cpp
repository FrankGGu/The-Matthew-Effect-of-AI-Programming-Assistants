#include <vector>
#include <queue>
using namespace std;

class Solution {
public:
    bool hasPath(vector<vector<int>>& maze, vector<int>& start, vector<int>& destination) {
        int m = maze.size(), n = maze[0].size();
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        vector<vector<int>> dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        queue<vector<int>> q;
        q.push(start);
        visited[start[0]][start[1]] = true;

        while (!q.empty()) {
            vector<int> cur = q.front();
            q.pop();
            if (cur[0] == destination[0] && cur[1] == destination[1]) 
                return true;

            for (auto& dir : dirs) {
                int x = cur[0] + dir[0];
                int y = cur[1] + dir[1];
                while (x >= 0 && x < m && y >= 0 && y < n && maze[x][y] == 0) {
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