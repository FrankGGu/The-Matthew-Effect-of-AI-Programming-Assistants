class Solution {
public:
    int maxJumps(vector<int>& arr, int d) {
        int n = arr.size();
        vector<int> dp(n, 1);
        vector<pair<int, int>> indexed;
        for (int i = 0; i < n; ++i) {
            indexed.emplace_back(arr[i], i);
        }
        sort(indexed.begin(), indexed.end());

        for (auto& [val, i] : indexed) {
            for (int j = i + 1; j <= min(i + d, n - 1); ++j) {
                if (arr[j] >= arr[i]) break;
                dp[i] = max(dp[i], dp[j] + 1);
            }
            for (int j = i - 1; j >= max(i - d, 0); --j) {
                if (arr[j] >= arr[i]) break;
                dp[i] = max(dp[i], dp[j] + 1);
            }
        }

        return *max_element(dp.begin(), dp.end());
    }
};