#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

int longestArithSeqLength(vector<int>& arr, int difference) {
    int n = arr.size();
    unordered_map<int, int> dp[n];
    int ans = 1;

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < i; ++j) {
            if (arr[i] - arr[j] == difference) {
                if (dp[j].count(arr[j])) {
                    dp[i][arr[i]] = dp[j][arr[j]] + 1;
                } else {
                    dp[i][arr[i]] = 2;
                }
                ans = max(ans, dp[i][arr[i]]);
            }
        }
        if (!dp[i].count(arr[i])) {
            dp[i][arr[i]] = 1;
        }
    }

    return ans;
}