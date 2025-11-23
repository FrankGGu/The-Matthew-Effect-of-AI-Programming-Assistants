#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int deleteAndEarn(vector<int>& nums) {
        if (nums.empty()) return 0;

        unordered_map<int, int> points;
        int max_num = 0;
        for (int num : nums) {
            points[num] += num;
            max_num = max(max_num, num);
        }

        vector<int> dp(max_num + 1, 0);
        dp[1] = points[1];

        for (int i = 2; i <= max_num; ++i) {
            dp[i] = max(dp[i - 1], dp[i - 2] + points[i]);
        }

        return dp[max_num];
    }
};