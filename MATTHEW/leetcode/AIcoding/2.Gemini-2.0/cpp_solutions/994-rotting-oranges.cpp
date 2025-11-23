#include <vector>
#include <queue>

using namespace std;

int orangesRotting(vector<vector<int>>& grid) {
    int rows = grid.size();
    int cols = grid[0].size();
    queue<pair<int, int>> q;
    int freshCount = 0;

    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            if (grid[i][j] == 2) {
                q.push({i, j});
            } else if (grid[i][j] == 1) {
                freshCount++;
            }
        }
    }

    int minutes = 0;
    vector<pair<int, int>> directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    while (!q.empty() && freshCount > 0) {
        int size = q.size();
        for (int i = 0; i < size; ++i) {
            pair<int, int> current = q.front();
            q.pop();

            for (auto& dir : directions) {
                int newRow = current.first + dir.first;
                int newCol = current.second + dir.second;

                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && grid[newRow][newCol] == 1) {
                    grid[newRow][newCol] = 2;
                    freshCount--;
                    q.push({newRow, newCol});
                }
            }
        }
        minutes++;
    }

    return (freshCount == 0) ? minutes : -1;
}