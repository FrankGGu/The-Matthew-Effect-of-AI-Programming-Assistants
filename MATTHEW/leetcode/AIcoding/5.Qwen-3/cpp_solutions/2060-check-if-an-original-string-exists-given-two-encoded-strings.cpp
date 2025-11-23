#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool possiblyEquals(string s, string t) {
        vector<int> s_counts;
        vector<int> t_counts;
        vector<char> s_chars;
        vector<char> t_chars;

        auto parse = [&](string& str, vector<int>& counts, vector<char>& chars) {
            int i = 0;
            while (i < str.size()) {
                if (isdigit(str[i])) {
                    int num = 0;
                    while (i < str.size() && isdigit(str[i])) {
                        num = num * 10 + (str[i] - '0');
                        i++;
                    }
                    counts.push_back(num);
                } else {
                    chars.push_back(str[i]);
                    counts.push_back(1);
                    i++;
                }
            }
        };

        parse(s, s_counts, s_chars);
        parse(t, t_counts, t_chars);

        int n = s_chars.size();
        int m = t_chars.size();

        if (n != m) return false;

        vector<vector<bool>> dp(n, vector<bool>(n, false));
        for (int i = 0; i < n; i++) {
            dp[i][i] = true;
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (s_chars[i] == t_chars[j]) {
                    if (i + 1 > j - 1 || dp[i + 1][j - 1]) {
                        dp[i][j] = true;
                    }
                }

                for (int k = i; k < j; k++) {
                    if (dp[i][k] && dp[k + 1][j]) {
                        dp[i][j] = true;
                        break;
                    }
                }

                if (dp[i][j]) continue;

                int s_num = 0;
                for (int k = i; k <= j; k++) {
                    if (s_counts[k] > 0) {
                        s_num += s_counts[k];
                    }
                }

                int t_num = 0;
                for (int k = i; k <= j; k++) {
                    if (t_counts[k] > 0) {
                        t_num += t_counts[k];
                    }
                }

                if (s_num == t_num) {
                    dp[i][j] = true;
                }
            }
        }

        return dp[0][n - 1];
    }
};