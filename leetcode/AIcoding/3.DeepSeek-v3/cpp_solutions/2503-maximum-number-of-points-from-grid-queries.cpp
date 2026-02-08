class Solution {
public:
    vector<int> maxPoints(vector<vector<int>>& grid, vector<int>& queries) {
        int m = grid.size();
        int n = grid[0].size();
        int k = queries.size();

        vector<pair<int, int>> qs;
        for (int i = 0; i < k; ++i) {
            qs.emplace_back(queries[i], i);
        }
        sort(qs.begin(), qs.end());

        vector<int> res(k);
        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<>> pq;
        pq.emplace(grid[0][0], 0, 0);
        grid[0][0] = 0;

        int cnt = 0;
        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        for (auto& [val, idx] : qs) {
            while (!pq.empty()) {
                auto [v, i, j] = pq.top();
                if (v >= val) break;
                pq.pop();
                cnt++;
                for (auto& d : dirs) {
                    int x = i + d[0];
                    int y = j + d[1];
                    if (x >= 0 && x < m && y >= 0 && y < n && grid[x][y] > 0) {
                        pq.emplace(grid[x][y], x, y);
                        grid[x][y] = 0;
                    }
                }
            }
            res[idx] = cnt;
        }
        return res;
    }
};