#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxJumps(vector<int>& arr, int d) {
        int n = arr.size();
        vector<int> dp(n, 0);
        vector<int> indices(n);
        for (int i = 0; i < n; ++i) {
            indices[i] = i;
        }
        sort(indices.begin(), indices.end(), [&](int i, int j) {
            return arr[i] < arr[j];
        });

        int ans = 0;
        for (int i = 0; i < n; ++i) {
            int idx = indices[i];
            dp[idx] = 1;

            for (int j = idx - 1; j >= max(0, idx - d); --j) {
                if (arr[j] >= arr[idx]) break;
                dp[idx] = max(dp[idx], dp[j] + 1);
            }

            for (int j = idx + 1; j <= min(n - 1, idx + d); ++j) {
                if (arr[j] >= arr[idx]) break;
                dp[idx] = max(dp[idx], dp[j] + 1);
            }
            ans = max(ans, dp[idx]);
        }

        return ans;
    }
};