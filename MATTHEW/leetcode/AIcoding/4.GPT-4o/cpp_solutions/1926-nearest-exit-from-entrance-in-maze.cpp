#include <vector>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    int nearestExit(vector<vector<char>>& maze, vector<int>& entrance) {
        int rows = maze.size(), cols = maze[0].size();
        queue<pair<int, int>> q;
        q.push({entrance[0], entrance[1]});
        maze[entrance[0]][entrance[1]] = '+';
        int steps = 0;

        vector<pair<int, int>> directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; i++) {
                auto [x, y] = q.front();
                q.pop();

                if ((x != entrance[0] || y != entrance[1]) && (x == 0 || x == rows - 1 || y == 0 || y == cols - 1)) {
                    return steps;
                }

                for (auto& dir : directions) {
                    int newX = x + dir.first, newY = y + dir.second;
                    if (newX >= 0 && newX < rows && newY >= 0 && newY < cols && maze[newX][newY] == '.') {
                        maze[newX][newY] = '+'; // Mark as visited
                        q.push({newX, newY});
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};