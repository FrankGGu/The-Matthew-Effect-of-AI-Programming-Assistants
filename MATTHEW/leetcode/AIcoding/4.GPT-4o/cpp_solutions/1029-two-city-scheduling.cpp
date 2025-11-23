class Solution {
public:
    int twoCitySchedCost(vector<vector<int>>& costs) {
        int n = costs.size() / 2;
        sort(costs.begin(), costs.end(), [](const vector<int>& a, const vector<int>& b) {
            return (a[0] - a[1]) < (b[0] - b[1]);
        });
        int totalCost = 0;
        for (int i = 0; i < n; ++i) {
            totalCost += costs[i][0] + costs[i + n][1];
        }
        return totalCost;
    }
};