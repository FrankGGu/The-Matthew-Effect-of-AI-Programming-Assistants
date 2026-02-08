class Solution {
public:
    int numFactoredBinaryTrees(vector<int>& arr) {
        long long mod = 1e9 + 7;
        sort(arr.begin(), arr.end());
        unordered_map<int, long long> dp;
        long long total = 0;

        for (int i = 0; i < arr.size(); ++i) {
            dp[arr[i]] = 1; // Each number can be a tree by itself
            for (int j = 0; j < i; ++j) {
                if (arr[i] % arr[j] == 0) {
                    int right = arr[i] / arr[j];
                    if (dp.count(right)) {
                        dp[arr[i]] = (dp[arr[i]] + dp[arr[j]] * dp[right]) % mod;
                    }
                }
            }
            total = (total + dp[arr[i]]) % mod;
        }
        return total;
    }
};