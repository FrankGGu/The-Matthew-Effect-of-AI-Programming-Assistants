#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string findOriginalString(string s) {
        int n = s.length();
        string original = "";
        vector<int> dp(n + 1, 0);
        dp[0] = 1;

        function<bool(int)> solve = [&](int i) {
            if (i == n) {
                return true;
            }
            if (dp[i] != 0) {
                return dp[i] == 1;
            }

            for (int len = 1; i + len <= n; ++len) {
                string sub = s.substr(i, len);
                bool isOriginal = true;
                for (int j = 0; j < (int)original.length() - (int)sub.length() + 1; ++j) {
                    if (original.substr(j, sub.length()) == sub) {
                        isOriginal = false;
                        break;
                    }
                }

                if (isOriginal) {
                    original += sub;
                    if (solve(i + len)) {
                        dp[i] = 1;
                        return true;
                    }
                    original = original.substr(0, original.length() - sub.length());
                }
            }

            dp[i] = -1;
            return false;
        };

        solve(0);
        return original;
    }
};