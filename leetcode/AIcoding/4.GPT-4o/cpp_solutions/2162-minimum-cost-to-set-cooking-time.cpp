class Solution {
public:
    int minCostSetTime(int t, int c) {
        int minCost = INT_MAX;
        for (int h = 0; h <= 99; ++h) {
            for (int m = 0; m < 60; ++m) {
                if (h * 60 + m == t) {
                    int cost = (h > 0 ? h * c : 0) + (m > 0 ? m * c : 0);
                    minCost = min(minCost, cost);
                }
            }
        }
        return minCost;
    }
};