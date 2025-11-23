#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int shortestPathBinaryMatrix(vector<vector<int>>& grid) {
        int n = grid.size();
        if (grid[0][0] == 1 || grid[n - 1][n - 1] == 1) return -1;

        queue<pair<int, int>> q;
        q.push({0, 0});
        grid[0][0] = 1;

        int dist = 1;
        vector<pair<int, int>> directions = {
            {-1, -1}, {-1, 0}, {-1, 1},
            {0, -1}, {0, 1},
            {1, -1}, {1, 0}, {1, 1}
        };

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int row = q.front().first;
                int col = q.front().second;
                q.pop();

                if (row == n - 1 && col == n - 1) return dist;

                for (auto& dir : directions) {
                    int newRow = row + dir.first;
                    int newCol = col + dir.second;

                    if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < n && grid[newRow][newCol] == 0) {
                        q.push({newRow, newCol});
                        grid[newRow][newCol] = 1; 
                    }
                }
            }
            dist++;
        }

        return -1;
    }
};