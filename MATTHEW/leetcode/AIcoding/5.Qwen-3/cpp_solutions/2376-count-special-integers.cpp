#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    int countSpecialIntegers(int n) {
        string s = to_string(n);
        int m = s.length();
        vector<vector<int>> dp(m + 1, vector<int>(10, 0));
        vector<int> f(10, 0);

        for (int i = 0; i < 10; ++i) {
            f[i] = 1;
        }

        for (int i = 1; i <= m; ++i) {
            for (int j = 0; j < 10; ++j) {
                if (i == 1) {
                    dp[i][j] = 1;
                } else {
                    dp[i][j] = dp[i - 1][j];
                    for (int k = 0; k < j; ++k) {
                        dp[i][j] += f[k];
                    }
                }
            }
            for (int j = 0; j < 10; ++j) {
                f[j] = dp[m][j];
            }
        }

        int res = 0;
        for (int i = 1; i < m; ++i) {
            res += 9 * pow(9, i - 1);
        }

        vector<bool> used(10, false);
        for (int i = 0; i < m; ++i) {
            int digit = s[i] - '0';
            for (int j = 0; j < digit; ++j) {
                if (!used[j]) {
                    res += dp[m - i - 1][j];
                }
            }
            if (used[digit]) {
                break;
            }
            used[digit] = true;
        }

        return res;
    }
};