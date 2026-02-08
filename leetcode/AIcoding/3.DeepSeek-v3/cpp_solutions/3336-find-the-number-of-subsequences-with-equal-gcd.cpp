#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countSubsequencesWithEqualGCD(vector<int>& nums) {
        int max_num = *max_element(nums.begin(), nums.end());
        vector<int> count(max_num + 1, 0);
        for (int num : nums) {
            count[num]++;
        }

        vector<int> dp(max_num + 1, 0);
        for (int i = max_num; i >= 1; --i) {
            int total = 0;
            for (int j = i; j <= max_num; j += i) {
                total += count[j];
            }
            if (total == 0) continue;
            dp[i] = (1LL << total) - 1;
            for (int j = 2 * i; j <= max_num; j += i) {
                dp[i] = (dp[i] - dp[j] + 1000000007) % 1000000007;
            }
        }
        return dp[1];
    }
};