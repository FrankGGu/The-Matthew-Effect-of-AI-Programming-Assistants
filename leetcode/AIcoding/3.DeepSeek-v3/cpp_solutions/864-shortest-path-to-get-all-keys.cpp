class Solution {
public:
    int shortestPathAllKeys(vector<string>& grid) {
        int m = grid.size(), n = grid[0].size();
        int all_keys = 0;
        queue<pair<pair<int, int>, int>> q;
        unordered_map<string, bool> visited;

        int start_x, start_y;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == '@') {
                    start_x = i;
                    start_y = j;
                } else if (islower(grid[i][j])) {
                    all_keys |= (1 << (grid[i][j] - 'a'));
                }
            }
        }

        q.push({{start_x, start_y}, 0});
        visited[to_string(start_x) + "," + to_string(start_y) + "," + to_string(0)] = true;
        int steps = 0;
        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto curr = q.front();
                q.pop();
                int x = curr.first.first;
                int y = curr.first.second;
                int keys = curr.second;

                if (keys == all_keys) {
                    return steps;
                }

                for (auto& dir : dirs) {
                    int nx = x + dir[0];
                    int ny = y + dir[1];
                    int nkeys = keys;

                    if (nx < 0 || nx >= m || ny < 0 || ny >= n || grid[nx][ny] == '#') {
                        continue;
                    }

                    char c = grid[nx][ny];
                    if (isupper(c)) {
                        if (!(keys & (1 << (c - 'A')))) {
                            continue;
                        }
                    } else if (islower(c)) {
                        nkeys |= (1 << (c - 'a'));
                    }

                    string state = to_string(nx) + "," + to_string(ny) + "," + to_string(nkeys);
                    if (!visited[state]) {
                        visited[state] = true;
                        q.push({{nx, ny}, nkeys});
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};