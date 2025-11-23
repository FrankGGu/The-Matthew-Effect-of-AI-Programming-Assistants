#include <vector>
#include <queue>

using namespace std;

vector<int> kthNearestObstacle(vector<vector<int>>& grid, vector<vector<int>>& queries) {
    int m = grid.size();
    int n = grid[0].size();
    vector<int> result;

    for (auto& query : queries) {
        int row = query[0];
        int col = query[1];
        int k = query[2];

        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        vector<vector<bool>> visited(m, vector<bool>(n, false));

        pq.push({0, {row, col}});
        visited[row][col] = true;

        int count = 0;
        int found = -1;

        while (!pq.empty()) {
            int dist = pq.top().first;
            int r = pq.top().second.first;
            int c = pq.top().second.second;
            pq.pop();

            if (grid[r][c] == 1) {
                count++;
                if (count == k) {
                    found = dist;
                    break;
                }
            }

            int dr[] = {0, 0, 1, -1};
            int dc[] = {1, -1, 0, 0};

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc]) {
                    pq.push({dist + 1, {nr, nc}});
                    visited[nr][nc] = true;
                }
            }
        }

        result.push_back(found);
    }

    return result;
}