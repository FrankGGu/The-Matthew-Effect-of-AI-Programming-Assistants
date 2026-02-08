class Solution {
public:
    int countNonSpecialNumbers(int n) {
        if (n < 10) return n;

        vector<int> dp(11, 0);
        dp[0] = 1;
        for (int i = 1; i <= 10; ++i) {
            dp[i] = dp[i - 1] * (10 - i + 1);
        }

        string s = to_string(n);
        int len = s.size(), count = 0;
        vector<bool> used(10, false);

        for (int i = 0; i < len; ++i) {
            int curr = s[i] - '0';
            for (int j = (i == 0) ? 1 : 0; j < curr; ++j) {
                if (!used[j]) {
                    count += dp[len - i - 1];
                }
            }
            if (used[curr]) break;
            used[curr] = true;
        }
        return count + 1;
    }
};