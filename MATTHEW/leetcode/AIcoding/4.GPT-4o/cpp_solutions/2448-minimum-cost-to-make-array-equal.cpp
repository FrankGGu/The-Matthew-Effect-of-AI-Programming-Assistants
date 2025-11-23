class Solution {
public:
    long long minCost(int n, int x) {
        long long totalCost = 0;
        long long median = (n + 1) / 2;

        for (int i = 1; i <= n; ++i) {
            totalCost += abs(i - median) * x;
        }

        return totalCost;
    }
};