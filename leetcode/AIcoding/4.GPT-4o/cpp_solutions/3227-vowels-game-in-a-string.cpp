class Solution {
public:
    string vowelsGame(string s) {
        int n = s.size();
        vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1];
            if (isVowel(s[i - 1])) {
                dp[i]++;
            }
        }

        int maxVowels = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j <= n; j++) {
                maxVowels = max(maxVowels, dp[j] - dp[i]);
            }
        }

        return maxVowels % 2 == 0 ? "Bob" : "Alice";
    }

    bool isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
               c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U';
    }
};