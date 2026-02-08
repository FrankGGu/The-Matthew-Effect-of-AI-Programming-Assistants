#include <vector>
#include <string>
#include <queue>
#include <utility>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimalSteps(vector<string>& maze) {
        int n = maze.size();
        int m = maze[0].size();
        pair<int, int> start, end;
        vector<pair<int, int>> bonuses;
        vector<pair<int, int>> stones;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (maze[i][j] == 'S') start = {i, j};
                else if (maze[i][j] == 'T') end = {i, j};
                else if (maze[i][j] == 'O') bonuses.push_back({i, j});
                else if (maze[i][j] == 'M') stones.push_back({i, j});
            }
        }

        int k = bonuses.size();
        int l = stones.size();
        const int INF = 1e9;

        auto bfs = [&](pair<int, int> p) {
            vector<vector<int>> dist(n, vector<int>(m, -1));
            queue<pair<int, int>> q;
            q.push(p);
            dist[p.first][p.second] = 0;
            int dx[] = {0, 0, 1, -1};
            int dy[] = {1, -1, 0, 0};
            while (!q.empty()) {
                auto curr = q.front();
                q.pop();
                for (int i = 0; i < 4; ++i) {
                    int nx = curr.first + dx[i];
                    int ny = curr.second + dy[i];
                    if (nx >= 0 && nx < n && ny >= 0 && ny < m && maze[nx][ny] != '#' && dist[nx][ny] == -1) {
                        dist[nx][ny] = dist[curr.first][curr.second] + 1;
                        q.push({nx, ny});
                    }
                }
            }
            return dist;
        };

        vector<vector<int>> start_dist = bfs(start);
        vector<vector<int>> end_dist = bfs(end);

        if (k == 0) {
            if (l == 0) {
                int res = start_dist[end.first][end.second];
                return res == -1 ? -1 : res;
            } else {
                int ans = INF;
                for (const auto& stone : stones) {
                    int dist_S_M = start_dist[stone.first][stone.second];
                    int dist_M_T = end_dist[stone.first][stone.second];
                    if (dist_S_M != -1 && dist_M_T != -1) {
                        ans = min(ans, dist_S_M + dist_M_T);
                    }
                }
                return ans == INF ? -1 : ans;
            }
        }

        if (l == 0) {
            return -1;
        }

        vector<vector<int>> bonus_dists(k);
        for (int i = 0; i < k; ++i) {
            bonus_dists[i] = bfs(bonuses[i]);
        }

        vector<int> dist_S_O(k);
        for (int i = 0; i < k; ++i) {
            dist_S_O[i] = start_dist[bonuses[i].first][bonuses[i].second];
        }

        vector<vector<int>> dist_O_O(k, vector<int>(k));
        for (int i = 0; i < k; ++i) {
            for (int j = 0; j < k; ++j) {
                dist_O_O[i][j] = bonus_dists[i][bonuses[j].first][bonuses[j].second];
            }
        }

        vector<vector<int>> dp(1 << k, vector<int>(k, INF));

        for (int i = 0; i < k; ++i) {
            if (dist_S_O[i] != -1) {
                dp[1 << i][i] = dist_S_O[i];
            }
        }

        for (int mask = 1; mask < (1 << k); ++mask) {
            for (int i = 0; i < k; ++i) {
                if ((mask >> i) & 1) {
                    if (dp[mask][i] == INF) continue;
                    for (int j = 0; j < k; ++j) {
                        if (!((mask >> j) & 1)) {
                            if (dist_O_O[i][j] != -1) {
                                int next_mask = mask | (1 << j);
                                dp[next_mask][j] = min(dp[next_mask][j], dp[mask][i] + dist_O_O[i][j]);
                            }
                        }
                    }
                }
            }
        }

        vector<int> cost_Oi_T(k, INF);
        for (int i = 0; i < k; ++i) {
            for (int j = 0; j < l; ++j) {
                int dist_O_M = bonus_dists[i][stones[j].first][stones[j].second];
                int dist_M_T = end_dist[stones[j].first][stones[j].second];
                if (dist_O_M != -1 && dist_M_T != -1) {
                    cost_Oi_T[i] = min(cost_Oi_T[i], dist_O_M + dist_M_T);
                }
            }
        }

        int final_mask = (1 << k) - 1;
        int ans = INF;
        for (int i = 0; i < k; ++i) {
            if (dp[final_mask][i] != INF && cost_Oi_T[i] != INF) {
                ans = min(ans, dp[final_mask][i] + cost_Oi_T[i]);
            }
        }

        return ans == INF ? -1 : ans;
    }
};