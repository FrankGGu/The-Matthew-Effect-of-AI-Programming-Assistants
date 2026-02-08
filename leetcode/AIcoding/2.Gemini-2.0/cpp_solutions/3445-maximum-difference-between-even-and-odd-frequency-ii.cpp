#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxDifference(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        vector<pair<int, int>> distinct_nums;
        for (auto const& [num, count] : freq) {
            distinct_nums.push_back({num, count});
        }

        int n = distinct_nums.size();
        vector<int> dp(n + 1, 0);
        int max_diff = 0;

        for (int i = 1; i <= n; ++i) {
            int num = distinct_nums[i - 1].first;
            int count = distinct_nums[i - 1].second;

            int score = (count % 2 == 0) ? count : -count;

            dp[i] = max(score, dp[i - 1] + score);
            max_diff = max(max_diff, dp[i]);
        }

        if (max_diff == 0) return -1;
        return max_diff;
    }
};