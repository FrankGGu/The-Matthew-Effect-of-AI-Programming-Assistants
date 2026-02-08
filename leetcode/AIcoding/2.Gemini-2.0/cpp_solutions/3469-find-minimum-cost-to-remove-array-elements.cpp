#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minCost(vector<int>& nums, vector<int>& cost) {
        int n = nums.size();
        vector<pair<int, int>> pairs(n);
        for (int i = 0; i < n; ++i) {
            pairs[i] = {nums[i], cost[i]};
        }
        sort(pairs.begin(), pairs.end());

        vector<long long> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + pairs[i].second;
        }

        long long totalCost = prefixSum[n];
        long long ans = -1;

        for (int i = 0; i < n; ++i) {
            long long currentCost = 0;
            for (int j = 0; j < n; ++j) {
                currentCost += (long long)abs(pairs[j].first - pairs[i].first) * pairs[j].second;
            }

            if (ans == -1 || currentCost < ans) {
                ans = currentCost;
            }
        }

        return ans;
    }
};