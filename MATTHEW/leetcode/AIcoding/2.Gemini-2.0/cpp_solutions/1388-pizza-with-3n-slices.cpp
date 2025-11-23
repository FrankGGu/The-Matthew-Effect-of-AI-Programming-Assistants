#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSizeSlices(vector<int>& slices) {
        int n = slices.size();
        int k = n / 3;

        auto solve = [&](vector<int> arr) {
            int m = arr.size();
            vector<vector<int>> dp(m, vector<int>(k + 1, 0));

            for (int i = 0; i < m; ++i) {
                dp[i][1] = arr[i];
            }

            for (int j = 2; j <= k; ++j) {
                for (int i = 0; i < m; ++i) {
                    dp[i][j] = arr[i];
                    if (i > 0) {
                        dp[i][j] += dp[i - 1][j - 1];
                    } else {
                        dp[i][j] += 0;
                    }

                    if (i > 1) {
                        dp[i][j] = max(dp[i][j], dp[i - 2][j - 1] + arr[i]);
                    }

                    if (i > 0)
                    {
                        dp[i][j] = max(dp[i][j], dp[i-1][j]);
                    }
                }
            }

            int res = 0;
            for(int i = 0; i < m; ++i)
            {
                res = max(res, dp[i][k]);
            }
            return res;
        };

        vector<int> arr1(slices.begin(), slices.end() - 1);
        vector<int> arr2(slices.begin() + 1, slices.end());

        return max(solve(arr1), solve(arr2));
    }
};