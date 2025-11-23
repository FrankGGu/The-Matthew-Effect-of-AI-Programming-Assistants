#include <vector>
#include <queue>
#include <algorithm>

class Solution {
public:
    int m, n;
    std::vector<std::vector<int>> fire_spread_time;
    int dr[4] = {-1, 1, 0, 0};
    int dc[4] = {0, 0, -1, 1};

    void calculateFireSpread(const std::vector<std::vector<int>>& grid) {
        m = grid.size();
        n = grid[0].size();
        fire_spread_time.assign(m, std::vector<int>(n, -1));

        std::queue<std::pair<int, int>> q;

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (grid[r][c] == 1) {
                    q.push({r, c});
                    fire_spread_time[r][c] = 0;
                }
            }
        }

        int time = 0;
        while (!q.empty()) {
            int size = q.size();
            time++;
            for (int i = 0; i < size; ++i) {
                std::pair<int, int> curr = q.front();
                q.pop();

                for (int k = 0; k < 4; ++k) {
                    int nr = curr.first + dr[k];
                    int nc = curr.second + dc[k];

                    if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] != 2 && fire_spread_time[nr][nc] == -1) {
                        fire_spread_time[nr][nc] = time;
                        q.push({nr, nc});
                    }
                }
            }
        }

        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (fire_spread_time[r][c] == -1) {
                    fire_spread_time[r][c] = 2000000000; 
                }
            }
        }
    }

    bool canEscape(int wait_time, const std::vector<std::vector<int>>& grid) {
        if (grid[0][0] == 2 || grid[m-1][n-1] == 2) return false;

        if (fire_spread_time[0][0] <= wait_time) {
            return false;
        }

        std::vector<std::vector<int>> person_reach_time(m, std::vector<int>(n, -1));
        std::queue<std::pair<int, int>> q;

        q.push({0, 0});
        person_reach_time[0][0] = wait_time;

        int current_person_time = wait_time;
        while (!q.empty()) {
            int size = q.size();
            current_person_time++;

            for (int i = 0; i < size; ++i) {
                std::pair<int, int> curr = q.front();
                q.pop();

                for (int k = 0; k < 4; ++k) {
                    int nr = curr.first + dr[k];
                    int nc = curr.second + dc[k];

                    if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] != 2 && person_reach_time[nr][nc] == -1) {
                        bool is_safe;
                        if (nr == m - 1 && nc == n - 1) {
                            is_safe = (fire_spread_time[nr][nc] >= current_person_time);
                        } else {
                            is_safe = (fire_spread_time[nr][nc] > current_person_time);
                        }

                        if (is_safe) {
                            if (nr == m - 1 && nc == n - 1) {
                                return true;
                            }
                            person_reach_time[nr][nc] = current_person_time;
                            q.push({nr, nc});
                        }
                    }
                }
            }
        }

        return false;
    }

    int maximumSafenessFactor(std::vector<std::vector<int>>& grid) {
        calculateFireSpread(grid);

        int low = 0;
        int high = 1000000000;
        int ans = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canEscape(mid, grid)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }
};