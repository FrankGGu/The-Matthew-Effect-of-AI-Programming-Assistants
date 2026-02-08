#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minChanges(vector<int>& nums, int k) {
        int n = nums.size();
        int ans = 0;
        vector<int> dp(1024, n);
        dp[0] = 0;
        for (int i = 0; i < k; i++) {
            unordered_map<int, int> cnt;
            int total = 0;
            for (int j = i; j < n; j += k) {
                cnt[nums[j]]++;
                total++;
            }
            int minVal = n;
            for (auto& [val, count] : cnt) {
                minVal = min(minVal, total - count);
            }
            vector<int> new_dp(1024, n);
            for (int mask = 0; mask < 1024; mask++) {
                for (auto& [val, count] : cnt) {
                    new_dp[mask ^ val] = min(new_dp[mask ^ val], dp[mask] + total - count);
                }
                new_dp[mask] = min(new_dp[mask], dp[mask] + minVal);
            }
            dp = new_dp;
        }
        return dp[0];
    }
};