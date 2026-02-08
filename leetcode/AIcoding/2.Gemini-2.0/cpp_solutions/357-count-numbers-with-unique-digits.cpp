class Solution {
public:
    int countNumbersWithUniqueDigits(int n) {
        if (n == 0) return 1;
        if (n > 10) n = 10;
        int dp[11];
        dp[0] = 1;
        dp[1] = 10;
        int ans = 10;
        int uniqueDigits = 9;
        int availableNumber = 9;
        for (int i = 2; i <= n; i++) {
            uniqueDigits = uniqueDigits * availableNumber;
            dp[i] = dp[i - 1] + uniqueDigits;
            ans += uniqueDigits;
            availableNumber--;
        }
        return ans;
    }
};