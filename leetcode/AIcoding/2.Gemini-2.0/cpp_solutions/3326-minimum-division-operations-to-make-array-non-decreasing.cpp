#include <vector>
#include <algorithm>

using namespace std;

int minimumDivisionOperations(vector<int>& nums) {
    int n = nums.size();
    vector<int> dp(n, 1e9);
    dp[0] = 0;

    for (int i = 1; i < n; ++i) {
        for (int j = 0; j < i; ++j) {
            if (nums[i] >= nums[j]) {
                dp[i] = min(dp[i], dp[j]);
            } else {
                int ops = 0;
                long long a = nums[i];
                long long b = nums[j];

                while (a < b) {
                    b = (b + 1) / 2;
                    ops++;
                }
                if (b >= a) {
                    dp[i] = min(dp[i], dp[j] + ops);
                }
            }
        }
    }

    return dp[n - 1];
}