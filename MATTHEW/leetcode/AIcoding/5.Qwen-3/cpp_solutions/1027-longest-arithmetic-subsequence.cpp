#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> longestArithSeqSubseq(vector<int>& nums) {
        int n = nums.size();
        if (n <= 2) return nums;

        vector<unordered_map<int, int>> dp(n);
        vector<int> result;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                int diff = nums[i] - nums[j];
                int count = dp[j].count(diff) ? dp[j][diff] + 1 : 2;
                dp[i][diff] = max(dp[i][diff], count);
                if (dp[i][diff] > result.size()) {
                    result.clear();
                    result.push_back(nums[i]);
                    result.push_back(nums[j]);
                    for (int k = j - 1; k >= 0 && dp[j][diff] > 1; --k) {
                        if (nums[k] == nums[j] - diff) {
                            result.insert(result.begin(), nums[k]);
                            j = k;
                            break;
                        }
                    }
                }
            }
        }

        return result;
    }
};