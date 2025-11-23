#include <vector>

using namespace std;

class Solution {
public:
    int countSpecialIntegers(int n) {
        string s = to_string(n);
        int len = s.length();
        vector<vector<int>> dp(len, vector<int>(1 << 10, -1));

        function<int(int, int, bool, bool)> solve = 
            [&](int index, int mask, bool isLimit, bool isNum) {
            if (index == len) {
                return isNum ? 1 : 0;
            }

            if (!isLimit && isNum && dp[index][mask] != -1) {
                return dp[index][mask];
            }

            int up = isLimit ? (s[index] - '0') : 9;
            int ans = 0;

            if (!isNum) {
                ans += solve(index + 1, mask, false, false);
            }

            for (int i = (isNum ? 0 : 1); i <= up; ++i) {
                if ((mask & (1 << i)) == 0) {
                    ans += solve(index + 1, mask | (1 << i), isLimit && (i == up), true);
                }
            }

            if (!isLimit && isNum) {
                dp[index][mask] = ans;
            }

            return ans;
        };

        return solve(0, 0, true, false);
    }
};