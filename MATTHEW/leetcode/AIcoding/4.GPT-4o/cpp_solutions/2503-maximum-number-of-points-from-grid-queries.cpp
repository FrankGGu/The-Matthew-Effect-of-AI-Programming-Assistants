class Solution {
public:
    vector<long long> maxPoints(vector<vector<int>>& grid, vector<vector<int>>& queries) {
        int m = grid.size(), n = grid[0].size();
        vector<long long> result(queries.size());
        vector<pair<int, int>> points;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                points.emplace_back(grid[i][j], i * n + j);
            }
        }

        sort(points.begin(), points.end(), greater<>());
        sort(queries.begin(), queries.end(), greater<>());

        vector<long long> prefixSum(m + 1, 0);
        vector<int> count(m * n, 0);
        int countPoints = 0, k = 0;

        for (const auto& q : queries) {
            while (k < points.size() && points[k].first >= q[0]) {
                int x = points[k].second / n;
                int y = points[k].second % n;
                if (count[x * n + y] == 0) countPoints++;
                count[x * n + y]++;
                k++;
            }
            result[q[1]] = countPoints;
        }

        return result;
    }
};