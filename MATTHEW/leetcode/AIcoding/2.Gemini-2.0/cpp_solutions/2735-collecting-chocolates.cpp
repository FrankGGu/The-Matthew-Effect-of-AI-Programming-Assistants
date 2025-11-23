#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minCost(vector<int>& costs, int money) {
        int n = costs.size();
        long long ans = -1;

        for (int mask = 0; mask < (1 << n); ++mask) {
            long long current_cost = 0;
            int count = 0;

            for (int i = 0; i < n; ++i) {
                if ((mask >> i) & 1) {
                    current_cost += costs[i];
                    count++;
                }
            }

            if (count == money) {
                if (ans == -1 || current_cost < ans) {
                    ans = current_cost;
                }
            }
        }

        return ans;
    }
};