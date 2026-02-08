#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int specialPermutations(vector<int>& nums) {
        int n = nums.size();
        vector<vector<int>> dp(n, vector<int>(1 << n, 0));
        unordered_map<int, vector<int>> pos;

        for (int i = 0; i < n; ++i) {
            pos[nums[i]].push_back(i);
        }

        for (int i = 0; i < n; ++i) {
            dp[i][1 << i] = 1;
        }

        for (int mask = 1; mask < (1 << n); ++mask) {
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i))) continue;
                for (int j = 0; j < n; ++j) {
                    if (mask & (1 << j)) continue;
                    if (nums[j] % nums[i] == 0) {
                        dp[j][mask | (1 << j)] += dp[i][mask];
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            result += dp[i][(1 << n) - 1];
        }

        return result;
    }
};