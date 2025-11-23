#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int lenLongestFibSubseq(vector<int>& arr) {
        int n = arr.size();
        unordered_map<int, int> index;
        for (int i = 0; i < n; ++i) {
            index[arr[i]] = i;
        }

        vector<vector<int>> dp(n, vector<int>(n, 2));
        int ans = 0;

        for (int k = 1; k < n; ++k) {
            for (int j = 0; j < k; ++j) {
                int i_val = arr[k] - arr[j];
                if (i_val < arr[j] && index.count(i_val)) {
                    int i = index[i_val];
                    dp[j][k] = dp[i][j] + 1;
                    ans = max(ans, dp[j][k]);
                }
            }
        }

        return ans > 2 ? ans : 0;
    }
};