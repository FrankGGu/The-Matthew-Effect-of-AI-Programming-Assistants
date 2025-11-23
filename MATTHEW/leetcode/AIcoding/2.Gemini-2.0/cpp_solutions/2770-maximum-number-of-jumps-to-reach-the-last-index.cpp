#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxJumps(vector<int>& arr, int d) {
        int n = arr.size();
        vector<int> dp(n, 1);
        vector<int> idx(n);
        for (int i = 0; i < n; ++i) {
            idx[i] = i;
        }
        sort(idx.begin(), idx.end(), [&](int i, int j) {
            return arr[i] < arr[j];
        });

        for (int i = 0; i < n; ++i) {
            int curr = idx[i];
            for (int j = curr + 1; j <= min(curr + d, n - 1); ++j) {
                if (arr[j] >= arr[curr]) break;
                dp[j] = max(dp[j], dp[curr] + 1);
            }
            for (int j = curr - 1; j >= max(curr - d, 0); --j) {
                if (arr[j] >= arr[curr]) break;
                dp[j] = max(dp[j], dp[curr] + 1);
            }
        }

        return *max_element(dp.begin(), dp.end());
    }
};