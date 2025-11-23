#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> dp(n + 1, 1e9);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= i; ++j) {
                vector<int> subarray(nums.begin() + i - j, nums.begin() + i);
                int cost = k;
                vector<int> counts(n, 0);
                int redundant = 0;
                for (int num : subarray) {
                    if (counts[num - 1] == 0) {
                        counts[num - 1] = 1;
                    } else if (counts[num - 1] == 1) {
                        redundant++;
                        counts[num - 1] = 2;
                    }
                }
                cost += redundant;
                dp[i] = min(dp[i], dp[i - j] + cost);
            }
        }

        return dp[n];
    }
};