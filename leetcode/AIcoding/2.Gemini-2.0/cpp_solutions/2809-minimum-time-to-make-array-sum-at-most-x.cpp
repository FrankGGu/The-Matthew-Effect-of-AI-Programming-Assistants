#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumTime(vector<int>& nums1, vector<int>& nums2, int x) {
        int n = nums1.size();
        vector<pair<int, int>> indices(n);
        for (int i = 0; i < n; ++i) {
            indices[i] = {i, i};
        }
        sort(indices.begin(), indices.end(), [&](const auto& a, const auto& b) {
            return nums2[a.first] < nums2[b.first];
        });

        int sum1 = 0;
        for (int num : nums1) {
            sum1 += num;
        }

        int ans = -1;
        for (int k = 0; k <= n; ++k) {
            vector<vector<int>> dp(k + 1, vector<int>(n + 1, 1e9 + 7));
            dp[0][0] = 0;

            for (int i = 0; i < n; ++i) {
                int index = indices[i].first;
                for (int j = k; j >= 1; --j) {
                    for (int t = i; t >= 0; --t) {
                        dp[j][t + 1] = min(dp[j][t + 1], dp[j - 1][t] + nums1[index] + nums2[index] * k);
                    }
                }
            }

            int min_dp = 1e9 + 7;
            for(int t = 0; t <= n; ++t){
                min_dp = min(min_dp, dp[k][t]);
            }

            if (sum1 + accumulate(nums2.begin(), nums2.end(), 0) * k - min_dp <= x) {
                ans = k;
                break;
            }
        }

        return ans;
    }
};