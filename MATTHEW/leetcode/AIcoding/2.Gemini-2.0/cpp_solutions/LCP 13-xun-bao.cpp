#include <vector>
#include <queue>

using namespace std;

int minimalSteps(vector<string>& grid) {
    int m = grid.size();
    int n = grid[0].size();

    vector<pair<int, int>> stones;
    pair<int, int> start, target;
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            if (grid[i][j] == 'M') {
                start = {i, j};
            } else if (grid[i][j] == 'T') {
                target = {i, j};
            } else if (grid[i][j] == 'O') {
                stones.push_back({i, j});
            }
        }
    }

    int stone_count = stones.size();

    auto bfs = [&](int start_row, int start_col, vector<pair<int, int>>& targets) {
        vector<vector<int>> dist(m, vector<int>(n, -1));
        queue<pair<int, int>> q;
        q.push({start_row, start_col});
        dist[start_row][start_col] = 0;

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        while (!q.empty()) {
            auto [row, col] = q.front();
            q.pop();

            for (int i = 0; i < 4; ++i) {
                int new_row = row + dx[i];
                int new_col = col + dy[i];

                if (new_row >= 0 && new_row < m && new_col >= 0 && new_col < n &&
                    grid[new_row][new_col] != '#' && dist[new_row][new_col] == -1) {
                    dist[new_row][new_col] = dist[row][col] + 1;
                    q.push({new_row, new_col});
                }
            }
        }

        vector<int> res;
        for (auto [target_row, target_col] : targets) {
            res.push_back(dist[target_row][target_col]);
        }
        return res;
    };

    vector<pair<int, int>> all_targets = stones;
    all_targets.push_back(start);
    all_targets.push_back(target);

    vector<vector<int>> dist(stone_count + 2, vector<int>(stone_count + 2, -1));

    for (int i = 0; i < stone_count + 2; ++i) {
        vector<pair<int, int>> targets;
        for (int j = 0; j < stone_count + 2; ++j) {
            if (i != j) {
                targets.push_back(all_targets[j]);
            }
        }

        vector<int> bfs_res = bfs(all_targets[i].first, all_targets[i].second, targets);

        int k = 0;
        for (int j = 0; j < stone_count + 2; ++j) {
            if (i != j) {
                dist[i][j] = bfs_res[k++];
            }
        }
    }

    int end_node = stone_count + 1;

    vector<vector<int>> dp((1 << stone_count), vector<int>(stone_count + 1, -1));

    function<int(int, int)> solve = [&](int mask, int node) {
        if (mask == (1 << stone_count) - 1) {
            return dist[node][end_node];
        }

        if (dp[mask][node] != -1) {
            return dp[mask][node];
        }

        int res = INT_MAX;
        for (int i = 0; i < stone_count; ++i) {
            if (!(mask & (1 << i)) && dist[node][i] != -1) {
                int next_mask = mask | (1 << i);
                int next_res = solve(next_mask, i);
                if (next_res != -1) {
                    res = min(res, dist[node][i] + next_res);
                }
            }
        }

        return dp[mask][node] = (res == INT_MAX ? -1 : res);
    };

    int ans = -1;
    if(stone_count == 0){
        vector<pair<int, int>> t;
        t.push_back(target);
        vector<int> b = bfs(start.first, start.second, t);
        ans = b[0];
    } else {
        ans = solve(0, stone_count);
    }

    return ans;
}