#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minDeletionSize(vector<string>& A) {
        int n = A.size(), m = A[0].size();
        vector<int> dp(m, 1);
        for (int j = 1; j < m; ++j) {
            for (int i = 1; i < n; ++i) {
                if (A[i][j] >= A[i-1][j]) {
                    dp[j] = max(dp[j], dp[j-1] + 1);
                } else {
                    dp[j] = max(dp[j], 1);
                }
            }
        }
        return m - *max_element(dp.begin(), dp.end());
    }
};