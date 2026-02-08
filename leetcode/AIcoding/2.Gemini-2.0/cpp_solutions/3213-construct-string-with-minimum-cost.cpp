#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(int n, int cost0, int cost1) {
        if (n == 1) return 0;
        if (n == 2) return min(cost0, cost1);

        long long dp0 = cost0;
        long long dp1 = cost1;

        for (int i = 3; i <= n; ++i) {
            long long new_dp0 = min((long long)cost0 + dp0, (long long)cost0 + dp1);
            long long new_dp1 = min((long long)cost1 + dp0, (long long)cost1 + dp1);

            dp0 = new_dp0;
            dp1 = new_dp1;
        }

        return min(dp0, dp1);
    }
};