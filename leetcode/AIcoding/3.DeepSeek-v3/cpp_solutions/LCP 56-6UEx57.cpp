class Solution {
public:
    int conveyorBelt(vector<string>& matrix, vector<int>& start, vector<int>& end) {
        int m = matrix.size();
        int n = matrix[0].size();
        vector<vector<int>> dist(m, vector<int>(n, INT_MAX));
        deque<pair<int, int>> q;
        q.push_back({start[0], start[1]});
        dist[start[0]][start[1]] = 0;

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        char symbols[4] = {'^', 'v', '<', '>'};

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop_front();
            if (x == end[0] && y == end[1]) {
                return dist[x][y];
            }
            for (int i = 0; i < 4; ++i) {
                int nx = x + dirs[i][0];
                int ny = y + dirs[i][1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int cost = (matrix[x][y] == symbols[i]) ? 0 : 1;
                    if (dist[nx][ny] > dist[x][y] + cost) {
                        dist[nx][ny] = dist[x][y] + cost;
                        if (cost == 0) {
                            q.push_front({nx, ny});
                        } else {
                            q.push_back({nx, ny});
                        }
                    }
                }
            }
        }
        return -1;
    }
};