#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumCost(vector<int>& cost) {
        sort(cost.begin(), cost.end());
        int n = cost.size();
        int minCost = 0;
        for (int i = n - 1; i >= 0; i--) {
            minCost += cost[i];
            if (i > 0) {
                i--;
            }
            if (i > 0) {
                i--;
            }
        }
        return minCost;
    }
};