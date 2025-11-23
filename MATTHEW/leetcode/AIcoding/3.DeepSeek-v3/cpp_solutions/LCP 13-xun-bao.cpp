class Solution {
public:
    int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    int minimalSteps(vector<string>& maze) {
        int m = maze.size(), n = maze[0].size();
        vector<vector<int>> dist(m, vector<int>(n, -1));
        queue<pair<int, int>> q;
        int start_x = -1, start_y = -1;
        int target_x = -1, target_y = -1;
        vector<pair<int, int>> buttons;
        vector<pair<int, int>> stones;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (maze[i][j] == 'S') {
                    start_x = i;
                    start_y = j;
                } else if (maze[i][j] == 'T') {
                    target_x = i;
                    target_y = j;
                } else if (maze[i][j] == 'M') {
                    buttons.emplace_back(i, j);
                } else if (maze[i][j] == 'O') {
                    stones.emplace_back(i, j);
                }
            }
        }

        int nb = buttons.size();
        int ns = stones.size();
        vector<vector<int>> start_dist = bfs(start_x, start_y, maze);

        if (nb == 0) {
            return start_dist[target_x][target_y];
        }

        vector<vector<int>> dist_buttons(nb, vector<int>(nb + 2, -1));
        vector<vector<vector<int>>> button_dists;
        for (int i = 0; i < nb; ++i) {
            vector<vector<int>> d = bfs(buttons[i].first, buttons[i].second, maze);
            button_dists.push_back(d);
            dist_buttons[i][nb + 1] = d[target_x][target_y];
        }

        for (int i = 0; i < nb; ++i) {
            int tmp = -1;
            for (int k = 0; k < ns; ++k) {
                int mid_x = stones[k].first, mid_y = stones[k].second;
                if (button_dists[i][mid_x][mid_y] != -1 && start_dist[mid_x][mid_y] != -1) {
                    if (tmp == -1 || tmp > button_dists[i][mid_x][mid_y] + start_dist[mid_x][mid_y]) {
                        tmp = button_dists[i][mid_x][mid_y] + start_dist[mid_x][mid_y];
                    }
                }
            }
            dist_buttons[i][nb] = tmp;
            for (int j = i + 1; j < nb; ++j) {
                int mn = -1;
                for (int k = 0; k < ns; ++k) {
                    int mid_x = stones[k].first, mid_y = stones[k].second;
                    if (button_dists[i][mid_x][mid_y] != -1 && button_dists[j][mid_x][mid_y] != -1) {
                        if (mn == -1 || mn > button_dists[i][mid_x][mid_y] + button_dists[j][mid_x][mid_y]) {
                            mn = button_dists[i][mid_x][mid_y] + button_dists[j][mid_x][mid_y];
                        }
                    }
                }
                dist_buttons[i][j] = mn;
                dist_buttons[j][i] = mn;
            }
        }

        for (int i = 0; i < nb; ++i) {
            if (dist_buttons[i][nb] == -1 || dist_buttons[i][nb + 1] == -1) {
                return -1;
            }
        }

        vector<vector<int>> dp(1 << nb, vector<int>(nb, -1));
        for (int i = 0; i < nb; ++i) {
            dp[1 << i][i] = dist_buttons[i][nb];
        }

        for (int mask = 1; mask < (1 << nb); ++mask) {
            for (int i = 0; i < nb; ++i) {
                if ((mask & (1 << i)) {
                    for (int j = 0; j < nb; ++j) {
                        if (!(mask & (1 << j))) {
                            int next_mask = mask | (1 << j);
                            if (dp[next_mask][j] == -1 || dp[next_mask][j] > dp[mask][i] + dist_buttons[i][j]) {
                                dp[next_mask][j] = dp[mask][i] + dist_buttons[i][j];
                            }
                        }
                    }
                }
            }
        }

        int res = -1;
        int final_mask = (1 << nb) - 1;
        for (int i = 0; i < nb; ++i) {
            if (res == -1 || res > dp[final_mask][i] + dist_buttons[i][nb + 1]) {
                res = dp[final_mask][i] + dist_buttons[i][nb + 1];
            }
        }

        return res;
    }

    vector<vector<int>> bfs(int x, int y, vector<string>& maze) {
        int m = maze.size(), n = maze[0].size();
        vector<vector<int>> dist(m, vector<int>(n, -1));
        queue<pair<int, int>> q;
        q.push({x, y});
        dist[x][y] = 0;

        while (!q.empty()) {
            auto p = q.front();
            q.pop();
            int cur_x = p.first, cur_y = p.second;
            for (auto& dir : dirs) {
                int nx = cur_x + dir[0], ny = cur_y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n && maze[nx][ny] != '#' && dist[nx][ny] == -1) {
                    dist[nx][ny] = dist[cur_x][cur_y] + 1;
                    q.push({nx, ny});
                }
            }
        }

        return dist;
    }
};