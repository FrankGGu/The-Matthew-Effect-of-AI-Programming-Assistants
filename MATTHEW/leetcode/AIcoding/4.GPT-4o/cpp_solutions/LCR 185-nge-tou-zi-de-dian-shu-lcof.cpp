class Solution {
public:
    double[] twoSum(int n) {
        vector<int> dp(6 * n + 1, 0);
        for (int i = 1; i <= 6; i++) {
            dp[i] = 1;
        }
        for (int i = 2; i <= n; i++) {
            vector<int> temp(6 * n + 1, 0);
            for (int j = 0; j < dp.size(); j++) {
                for (int k = 1; k <= 6; k++) {
                    if (j + k < temp.size()) {
                        temp[j + k] += dp[j];
                    }
                }
            }
            dp = temp;
        }
        vector<double> res(5 * n + 1);
        double total = pow(6, n);
        for (int i = n; i <= 6 * n; i++) {
            res[i - n] = dp[i] / total;
        }
        return res;
    }
};