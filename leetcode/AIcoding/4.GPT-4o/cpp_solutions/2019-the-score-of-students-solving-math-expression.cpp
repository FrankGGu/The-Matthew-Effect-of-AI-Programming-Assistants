class Solution {
public:
    int scoreOfStudents(string s, vector<int>& answers) {
        int n = s.size();
        vector<int> dp(n + 1, INT_MIN);
        dp[0] = 0;
        for (int i = 1; i <= n; ++i) {
            if (isdigit(s[i - 1])) {
                dp[i] = max(dp[i], dp[i - 1] + s[i - 1] - '0');
            }
            for (int j = i - 1; j > 0; --j) {
                if (s[j - 1] == '+' || s[j - 1] == '*') {
                    for (int a = 0; a <= 1000; ++a) {
                        for (int b = 0; b <= 1000; ++b) {
                            if (dp[j - 1] == a && dp[i] == b) {
                                if (s[j - 1] == '+') {
                                    if (a + b <= 1000) {
                                        dp[i] = max(dp[i], a + b);
                                    }
                                } else {
                                    dp[i] = max(dp[i], a * b);
                                }
                            }
                        }
                    }
                }
            }
        }
        int correctAnswer = dp[n];
        unordered_set<int> uniqueAnswers(answers.begin(), answers.end());
        int score = 0;
        for (int ans : uniqueAnswers) {
            if (ans == correctAnswer) {
                score += 5;
            } else if (ans >= 0 && ans <= 1000) {
                score += 2;
            }
        }
        return score;
    }
};