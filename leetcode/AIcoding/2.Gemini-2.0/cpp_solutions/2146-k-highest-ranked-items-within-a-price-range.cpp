#include <vector>
#include <queue>
#include <tuple>

using namespace std;

class Solution {
public:
    vector<vector<int>> highestRankedKItems(vector<vector<int>>& grid, vector<int>& pricing, int startRow, int startCol, int k) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<int>> visited(m, vector<int>(n, 0));
        priority_queue<tuple<int, int, int, int>, vector<tuple<int, int, int, int>>, greater<tuple<int, int, int, int>>> pq;

        if (grid[startRow][startCol] >= pricing[0] && grid[startRow][startCol] <= pricing[1]) {
            pq.push({0, grid[startRow][startCol], startRow, startCol});
        } else if (grid[startRow][startCol] == 1) {
            pq.push({0, 2, startRow, startCol});
        }

        visited[startRow][startCol] = 1;

        vector<vector<int>> result;
        int count = 0;

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        queue<pair<int, int>> q;
        q.push({startRow, startCol});
        int distance = 0;

        while (!q.empty() && count < k) {
            int qSize = q.size();
            for (int i = 0; i < qSize; ++i) {
                int row = q.front().first;
                int col = q.front().second;
                q.pop();

                if (grid[row][col] >= pricing[0] && grid[row][col] <= pricing[1] && distance > 0) {
                    pq.push({distance, grid[row][col], row, col});
                }

                for (int j = 0; j < 4; ++j) {
                    int newRow = row + dx[j];
                    int newCol = col + dy[j];

                    if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && grid[newRow][newCol] != 0 && visited[newRow][newCol] == 0) {
                        visited[newRow][newCol] = 1;
                        q.push({newRow, newCol});
                    }
                }
            }
            distance++;
        }

        while (!pq.empty() && count < k) {
            result.push_back({get<2>(pq.top()), get<3>(pq.top())});
            pq.pop();
            count++;
        }

        return result;
    }
};