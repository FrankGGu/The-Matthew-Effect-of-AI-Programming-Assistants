#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int maximumMinutes(vector<vector<int>>& forest) {
        int m = forest.size();
        int n = forest[0].size();

        auto check = [&](int wait_time) {
            vector<vector<int>> fire_times(m, vector<int>(n, INT_MAX));
            queue<pair<int, int>> fire_q;

            for (int i = 0; i < m; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (forest[i][j] == 1) {
                        fire_times[i][j] = 0;
                        fire_q.push({i, j});
                    }
                }
            }

            int fire_time = 1;
            int dx[] = {0, 0, 1, -1};
            int dy[] = {1, -1, 0, 0};

            while (!fire_q.empty()) {
                int size = fire_q.size();
                for (int k = 0; k < size; ++k) {
                    int x = fire_q.front().first;
                    int y = fire_q.front().second;
                    fire_q.pop();

                    for (int i = 0; i < 4; ++i) {
                        int nx = x + dx[i];
                        int ny = y + dy[i];

                        if (nx >= 0 && nx < m && ny >= 0 && ny < n && forest[nx][ny] != 2 && fire_times[nx][ny] == INT_MAX) {
                            fire_times[nx][ny] = fire_time;
                            fire_q.push({nx, ny});
                        }
                    }
                }
                fire_time++;
            }

            vector<vector<bool>> visited(m, vector<bool>(n, false));
            queue<pair<int, int>> person_q;
            person_q.push({0, 0});
            visited[0][0] = true;
            int person_time = wait_time;

            while (!person_q.empty()) {
                int size = person_q.size();
                for (int k = 0; k < size; ++k) {
                    int x = person_q.front().first;
                    int y = person_q.front().second;
                    person_q.pop();

                    if (x == m - 1 && y == n - 1) {
                        return true;
                    }

                    for (int i = 0; i < 4; ++i) {
                        int nx = x + dx[i];
                        int ny = y + dy[i];

                        if (nx >= 0 && nx < m && ny >= 0 && ny < n && forest[nx][ny] != 2 && !visited[nx][ny]) {
                            if (person_time + 1 < fire_times[nx][ny]) {
                                person_q.push({nx, ny});
                                visited[nx][ny] = true;
                            } else if (nx == m - 1 && ny == n - 1 && person_time + 1 == fire_times[nx][ny]) {
                                return true;
                            }
                        }
                    }
                }
                person_time++;
            }
            return false;
        };

        int left = 0, right = m * n;
        int ans = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (check(mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        if (ans == m * n) {
            return 1e9;
        }

        return ans;
    }
};