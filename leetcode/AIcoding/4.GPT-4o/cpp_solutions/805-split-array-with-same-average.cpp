class Solution {
public:
    bool splitArraySameAverage(vector<int>& A) {
        int n = A.size(), total = accumulate(A.begin(), A.end(), 0);
        sort(A.begin(), A.end());

        for (int k = 1; k <= n / 2; ++k) {
            if (total * k % n != 0) continue;
            int target = total * k / n;
            if (canSplit(A, n, k, target)) return true;
        }
        return false;
    }

private:
    bool canSplit(vector<int>& A, int n, int k, int target) {
        vector<vector<bool>> dp(k + 1, vector<bool>(target + 1, false));
        dp[0][0] = true;

        for (int num : A) {
            for (int i = k; i >= 1; --i) {
                for (int j = target; j >= num; --j) {
                    dp[i][j] = dp[i][j] || dp[i - 1][j - num];
                }
            }
        }
        return dp[k][target];
    }
};