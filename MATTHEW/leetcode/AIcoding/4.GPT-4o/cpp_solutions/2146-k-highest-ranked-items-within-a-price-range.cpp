class Solution {
public:
    vector<vector<int>> highestRankedKItems(vector<vector<int>>& grid, vector<int>& pricing, int k) {
        int rows = grid.size(), cols = grid[0].size();
        vector<vector<int>> result;
        int minPrice = pricing[0], maxPrice = pricing[1];
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] >= minPrice && grid[i][j] <= maxPrice) {
                    pq.push({grid[i][j], {i, j}});
                }
            }
        }

        while (!pq.empty() && result.size() < k) {
            auto [price, pos] = pq.top();
            pq.pop();
            result.push_back({pos.first, pos.second});
        }

        sort(result.begin(), result.end(), [](const vector<int>& a, const vector<int>& b) {
            if (a[0] != b[0]) return a[0] < b[0];
            return a[1] < b[1];
        });

        return result;
    }
};