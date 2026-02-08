#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numDupDigitsAtMostN(int n) {
        string s = to_string(n);
        int len = s.length();
        vector<int> dp(len + 1, 0);
        dp[0] = 1;
        for (int i = 1; i <= len; ++i) {
            dp[i] = dp[i - 1] * (10 - i + 1);
        }
        vector<bool> used(10, false);
        for (int i = 0; i < len; ++i) {
            int digit = s[i] - '0';
            for (int j = 0; j < digit; ++j) {
                if (!used[j]) {
                    dp[i + 1] -= dp[len - i - 1];
                }
            }
            if (used[digit]) {
                break;
            }
            used[digit] = true;
        }
        int res = 0;
        for (int i = 1; i < len; ++i) {
            res += dp[i];
        }
        return res;
    }
};