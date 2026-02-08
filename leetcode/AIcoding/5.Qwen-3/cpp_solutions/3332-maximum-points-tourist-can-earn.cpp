#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPoints(vector<int>& points) {
        int n = points.size();
        if (n == 0) return 0;
        if (n == 1) return points[0];

        vector<int> dp(n, 0);
        dp[0] = points[0];
        dp[1] = max(points[0], points[1]);

        for (int i = 2; i < n; ++i) {
            dp[i] = max(dp[i - 1], dp[i - 2] + points[i]);
        }

        return dp[n - 1];
    }
};