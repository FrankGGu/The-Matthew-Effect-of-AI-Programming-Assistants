#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumCost(vector<int>& cost) {
        int n = cost.size();
        if (n == 0) return 0;
        sort(cost.begin(), cost.end());
        int totalCost = 0;
        for (int i = 0; i < n; ++i) {
            totalCost += cost[i] * (i / 2 + 1);
        }
        return totalCost;
    }
};