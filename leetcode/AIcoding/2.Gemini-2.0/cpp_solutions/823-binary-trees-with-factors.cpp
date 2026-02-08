#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numFactoredBinaryTrees(vector<int>& arr) {
        sort(arr.begin(), arr.end());
        unordered_map<int, long long> dp;
        long long ans = 0;
        int mod = 1e9 + 7;

        for (int i = 0; i < arr.size(); ++i) {
            dp[arr[i]] = 1;
            for (int j = 0; j < i; ++j) {
                if (arr[i] % arr[j] == 0) {
                    int factor = arr[i] / arr[j];
                    if (dp.count(factor)) {
                        dp[arr[i]] = (dp[arr[i]] + dp[arr[j]] * dp[factor]) % mod;
                    }
                }
            }
            ans = (ans + dp[arr[i]]) % mod;
        }

        return ans;
    }
};