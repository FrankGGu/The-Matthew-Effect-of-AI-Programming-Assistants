#include <algorithm>

class Solution {
public:
    int minIncrements(int n, vector<int>& cost) {
        int ans = 0;
        for (int i = n / 2 - 1; i >= 0; --i) {
            ans += abs(cost[2 * i + 1] - cost[2 * i + 2]);
            cost[i] += max(cost[2 * i + 1], cost[2 * i + 2]);
        }
        return ans;
    }
};