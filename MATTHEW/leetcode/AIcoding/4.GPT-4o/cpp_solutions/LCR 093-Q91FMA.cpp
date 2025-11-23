class Solution {
public:
    int lenLongestFibSubseq(vector<int>& A) {
        int n = A.size();
        unordered_set<int> s(A.begin(), A.end());
        vector<vector<int>> dp(n, vector<int>(n, 2));
        int maxLength = 0;

        for (int j = 1; j < n; ++j) {
            for (int i = 0; i < j; ++i) {
                long long k = static_cast<long long>(A[j]) - A[i];
                if (k > 0 && s.count(k)) {
                    int idx = lower_bound(A.begin(), A.end(), k) - A.begin();
                    if (idx < i) {
                        dp[i][j] = dp[idx][i] + 1;
                        maxLength = max(maxLength, dp[i][j]);
                    }
                }
            }
        }
        return maxLength >= 3 ? maxLength : 0;
    }
};