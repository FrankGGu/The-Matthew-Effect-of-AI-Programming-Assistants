class Solution {
public:
    long long minCost(int n, vector<int>& cost) {
        long long totalCost = 0;
        for (int i = 0; i < n / 2; ++i) {
            totalCost += abs(cost[i] - cost[n - 1 - i]);
        }
        return totalCost;
    }
};