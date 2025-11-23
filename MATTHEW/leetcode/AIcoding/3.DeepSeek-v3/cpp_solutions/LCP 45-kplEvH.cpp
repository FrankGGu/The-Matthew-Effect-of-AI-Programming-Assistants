class Solution {
public:
    vector<vector<int>> bicycleYard(vector<int>& position, vector<vector<int>>& terrain, vector<vector<int>>& obstacle) {
        int m = terrain.size();
        if (m == 0) return {};
        int n = terrain[0].size();
        if (n == 0) return {};

        vector<vector<int>> res;
        vector<vector<unordered_set<int>>> visited(m, vector<unordered_set<int>>(n));
        queue<tuple<int, int, int>> q;
        q.push({position[0], position[1], 1});
        visited[position[0]][position[1]].insert(1);

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            auto [x, y, speed] = q.front();
            q.pop();

            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx < 0 || nx >= m || ny < 0 || ny >= n) continue;

                int delta = terrain[x][y] - terrain[nx][ny] - obstacle[nx][ny];
                int new_speed = speed + delta;
                if (new_speed <= 0) continue;

                if (visited[nx][ny].count(new_speed)) continue;
                visited[nx][ny].insert(new_speed);
                q.push({nx, ny, new_speed});

                if (new_speed == 1) {
                    res.push_back({nx, ny});
                }
            }
        }

        sort(res.begin(), res.end());
        return res;
    }
};