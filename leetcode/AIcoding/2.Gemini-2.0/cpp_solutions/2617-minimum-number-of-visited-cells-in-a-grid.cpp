#include <vector>
#include <queue>
#include <set>

using namespace std;

class Solution {
public:
    int minimumVisitedCells(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<int>> dist(m, vector<int>(n, -1));
        dist[0][0] = 1;

        queue<pair<int, int>> q;
        q.push({0, 0});

        vector<set<int>> rows(m);
        vector<set<int>> cols(n);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                rows[i].insert(j);
                cols[j].insert(i);
            }
        }

        while (!q.empty()) {
            int r = q.front().first;
            int c = q.front().second;
            q.pop();

            rows[r].erase(c);
            cols[c].erase(r);

            int steps = grid[r][c];

            for (auto it = rows[r].lower_bound(c + 1); it != rows[r].end() && *it <= c + steps;) {
                int nc = *it;
                if (dist[r][nc] == -1) {
                    dist[r][nc] = dist[r][c] + 1;
                    q.push({r, nc});
                }
                 it = rows[r].erase(it);
            }

            for (auto it = cols[c].lower_bound(r + 1); it != cols[c].end() && *it <= r + steps;) {
                int nr = *it;
                if (dist[nr][c] == -1) {
                    dist[nr][c] = dist[r][c] + 1;
                    q.push({nr, c});
                }
                it = cols[c].erase(it);
            }

            if (dist[m - 1][n - 1] != -1) break;
        }

        return dist[m - 1][n - 1];
    }
};