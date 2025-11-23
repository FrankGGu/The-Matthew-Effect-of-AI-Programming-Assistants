class Solution {
public:
    int minPushBox(vector<vector<char>>& grid) {
        int m = grid.size(), n = grid[0].size();
        int box_i = -1, box_j = -1, target_i = -1, target_j = -1, person_i = -1, person_j = -1;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 'B') {
                    box_i = i;
                    box_j = j;
                } else if (grid[i][j] == 'T') {
                    target_i = i;
                    target_j = j;
                } else if (grid[i][j] == 'S') {
                    person_i = i;
                    person_j = j;
                }
            }
        }

        auto isValid = [&](int i, int j) {
            return i >= 0 && i < m && j >= 0 && j < n && grid[i][j] != '#';
        };

        vector<vector<int>> dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        deque<tuple<int, int, int, int>> q;
        set<tuple<int, int, int, int>> visited;

        q.push_back({box_i, box_j, person_i, person_j});
        visited.insert({box_i, box_j, person_i, person_j});
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            while (size--) {
                auto [bi, bj, pi, pj] = q.front();
                q.pop_front();

                if (bi == target_i && bj == target_j) {
                    return steps;
                }

                for (auto& dir : dirs) {
                    int new_pi = pi + dir[0];
                    int new_pj = pj + dir[1];
                    if (!isValid(new_pi, new_pj)) continue;

                    if (new_pi == bi && new_pj == bj) {
                        int new_bi = bi + dir[0];
                        int new_bj = bj + dir[1];
                        if (!isValid(new_bi, new_bj)) continue;
                        if (visited.count({new_bi, new_bj, new_pi, new_pj})) continue;
                        visited.insert({new_bi, new_bj, new_pi, new_pj});
                        q.push_back({new_bi, new_bj, new_pi, new_pj});
                    } else {
                        if (visited.count({bi, bj, new_pi, new_pj})) continue;
                        visited.insert({bi, bj, new_pi, new_pj});
                        q.push_front({bi, bj, new_pi, new_pj});
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};