#include <vector>
#include <queue>

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

        vector<set<int>> row_reachable(m);
        vector<set<int>> col_reachable(n);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                row_reachable[i].insert(j);
                col_reachable[j].insert(i);
            }
        }

        while (!q.empty()) {
            int r = q.front().first;
            int c = q.front().second;
            q.pop();

            if (r == m - 1 && c == n - 1) {
                return dist[r][c];
            }

            int reach = grid[r][c];

            vector<int> to_remove_row;
            for (auto it = row_reachable[r].begin(); it != row_reachable[r].end(); ++it) {
                int nc = *it;
                if (nc >= c + 1 && nc <= min(c + reach, (int)n - 1) && dist[r][nc] == -1) {
                    dist[r][nc] = dist[r][c] + 1;
                    q.push({r, nc});
                    to_remove_row.push_back(nc);
                }
            }
            for (int nc : to_remove_row) {
                row_reachable[r].erase(nc);
                col_reachable[nc].erase(r);
            }

            vector<int> to_remove_col;
            for (auto it = col_reachable[c].begin(); it != col_reachable[c].end(); ++it) {
                int nr = *it;
                if (nr >= r + 1 && nr <= min(r + reach, (int)m - 1) && dist[nr][c] == -1) {
                    dist[nr][c] = dist[r][c] + 1;
                    q.push({nr, c});
                    to_remove_col.push_back(nr);
                }
            }
            for (int nr : to_remove_col) {
                col_reachable[c].erase(nr);
                row_reachable[nr].erase(c);
            }
        }

        return -1;
    }
};