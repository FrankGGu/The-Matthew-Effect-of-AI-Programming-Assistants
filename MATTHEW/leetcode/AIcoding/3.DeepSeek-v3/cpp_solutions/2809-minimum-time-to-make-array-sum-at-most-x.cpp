#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumTime(vector<int>& nums1, vector<int>& nums2, int x) {
        int n = nums1.size();
        vector<pair<int, int>> pairs;
        for (int i = 0; i < n; ++i) {
            pairs.emplace_back(nums2[i], nums1[i]);
        }
        sort(pairs.begin(), pairs.end());

        vector<int> dp(n + 1, 0);
        for (int j = 0; j < n; ++j) {
            int b = pairs[j].first;
            int a = pairs[j].second;
            for (int i = j + 1; i > 0; --i) {
                dp[i] = max(dp[i], dp[i - 1] + a + b * i);
            }
        }

        int sum1 = 0, sum2 = 0;
        for (int num : nums1) sum1 += num;
        for (int num : nums2) sum2 += num;

        for (int t = 0; t <= n; ++t) {
            if (sum1 + sum2 * t - dp[t] <= x) {
                return t;
            }
        }
        return -1;
    }
};