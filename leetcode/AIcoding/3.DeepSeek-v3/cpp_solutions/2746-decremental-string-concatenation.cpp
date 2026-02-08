class Solution {
public:
    int minimizeConcatenatedLength(vector<string>& words) {
        int n = words.size();
        if (n == 0) return 0;

        vector<vector<vector<int>>> dp(n, vector<vector<int>>(26, vector<int>(26, INT_MAX)));
        string first = words[0];
        dp[0][first[0] - 'a'][first.back() - 'a'] = first.length();

        for (int i = 1; i < n; ++i) {
            string curr = words[i];
            int len = curr.length();
            char firstChar = curr[0];
            char lastChar = curr.back();

            for (char a = 'a'; a <= 'z'; ++a) {
                for (char b = 'a'; b <= 'z'; ++b) {
                    if (dp[i-1][a - 'a'][b - 'a'] == INT_MAX) continue;

                    // Case 1: place current word after previous
                    int newLen1 = dp[i-1][a - 'a'][b - 'a'] + len;
                    if (b == firstChar) {
                        newLen1 -= 1;
                    }
                    if (newLen1 < dp[i][a - 'a'][lastChar - 'a']) {
                        dp[i][a - 'a'][lastChar - 'a'] = newLen1;
                    }

                    // Case 2: place current word before previous
                    int newLen2 = dp[i-1][a - 'a'][b - 'a'] + len;
                    if (a == lastChar) {
                        newLen2 -= 1;
                    }
                    if (newLen2 < dp[i][firstChar - 'a'][b - 'a']) {
                        dp[i][firstChar - 'a'][b - 'a'] = newLen2;
                    }
                }
            }
        }

        int result = INT_MAX;
        for (char a = 'a'; a <= 'z'; ++a) {
            for (char b = 'a'; b <= 'z'; ++b) {
                if (dp[n-1][a - 'a'][b - 'a'] < result) {
                    result = dp[n-1][a - 'a'][b - 'a'];
                }
            }
        }
        return result;
    }
};