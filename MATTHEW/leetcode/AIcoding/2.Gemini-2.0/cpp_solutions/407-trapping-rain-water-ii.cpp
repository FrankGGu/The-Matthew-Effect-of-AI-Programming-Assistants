#include <vector>
#include <queue>

using namespace std;

struct Cell {
    int row, col, height;
    Cell(int r, int c, int h) : row(r), col(c), height(h) {}
};

struct CompareHeight {
    bool operator()(const Cell& a, const Cell& b) {
        return a.height > b.height;
    }
};

class Solution {
public:
    int trapRainWater(vector<vector<int>>& heightMap) {
        if (heightMap.empty() || heightMap[0].empty()) return 0;

        int m = heightMap.size();
        int n = heightMap[0].size();

        priority_queue<Cell, vector<Cell>, CompareHeight> pq;
        vector<vector<bool>> visited(m, vector<bool>(n, false));

        for (int i = 0; i < m; ++i) {
            pq.push(Cell(i, 0, heightMap[i][0]));
            pq.push(Cell(i, n - 1, heightMap[i][n - 1]));
            visited[i][0] = true;
            visited[i][n - 1] = true;
        }

        for (int j = 1; j < n - 1; ++j) {
            pq.push(Cell(0, j, heightMap[0][j]));
            pq.push(Cell(m - 1, j, heightMap[m - 1][j]));
            visited[0][j] = true;
            visited[m - 1][j] = true;
        }

        int trappedWater = 0;
        int directions[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!pq.empty()) {
            Cell current = pq.top();
            pq.pop();

            for (auto& dir : directions) {
                int newRow = current.row + dir[0];
                int newCol = current.col + dir[1];

                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && !visited[newRow][newCol]) {
                    visited[newRow][newCol] = true;
                    int newHeight = heightMap[newRow][newCol];
                    trappedWater += max(0, current.height - newHeight);
                    pq.push(Cell(newRow, newCol, max(newHeight, current.height)));
                }
            }
        }

        return trappedWater;
    }
};