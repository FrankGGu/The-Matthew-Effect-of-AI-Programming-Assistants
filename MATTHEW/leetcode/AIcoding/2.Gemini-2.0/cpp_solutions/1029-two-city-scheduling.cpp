#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int twoCitySchedCost(vector<vector<int>>& costs) {
        sort(costs.begin(), costs.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[0] - a[1] < b[0] - b[1];
        });

        int n = costs.size() / 2;
        int totalCost = 0;

        for (int i = 0; i < n; ++i) {
            totalCost += costs[i][0];
        }

        for (int i = n; i < 2 * n; ++i) {
            totalCost += costs[i][1];
        }

        return totalCost;
    }
};