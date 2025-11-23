class Solution {
public:
    int countNumbersWithNonDecreasingDigits(int n) {
        if (n <= 0) return 0;

        string s = to_string(n);
        int length = s.size();
        vector<int> dp(length + 1);
        dp[0] = 1;

        for (int i = 1; i <= length; ++i) {
            dp[i] = dp[i - 1] * (10 - (i - 1));
            for (int j = 1; j < i; ++j) {
                dp[i] -= dp[j] * (10 - j);
            }
        }

        int count = 0;
        for (int i = 1; i < length; ++i) {
            count += dp[i];
        }

        for (int i = 0; i < length; ++i) {
            int currentDigit = s[i] - '0';
            for (int j = (i == 0 ? 1 : 0); j < currentDigit; ++j) {
                if (j >= (i > 0 ? s[i - 1] - '0' : 0)) {
                    count++;
                }
            }
            if (i > 0 && s[i] < s[i - 1]) break;
            if (i == length - 1) count++;
        }

        return count;
    }
};