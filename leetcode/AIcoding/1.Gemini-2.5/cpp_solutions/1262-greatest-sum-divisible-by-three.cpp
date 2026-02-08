#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSumDivThree(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(3, 0);

        for (int num : nums) {
            vector<int> temp(3);
            for (int i = 0; i < 3; ++i) {
                temp[(i + num % 3 + 3) % 3] = max(temp[(i + num % 3 + 3) % 3], dp[i] + num);
            }
            for (int i = 0; i < 3; ++i) {
                dp[i] = max(dp[i], temp[i]);
            }
        }

        return dp[0];
    }
};