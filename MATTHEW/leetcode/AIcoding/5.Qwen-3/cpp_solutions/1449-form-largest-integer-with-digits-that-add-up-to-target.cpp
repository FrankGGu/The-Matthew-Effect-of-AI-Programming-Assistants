#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestNumber(int target) {
        vector<int> dp(target + 1, -1);
        dp[0] = 0;
        for (int i = 1; i <= target; ++i) {
            for (int j = 1; j <= 9; ++j) {
                if (i >= j && dp[i - j] != -1) {
                    dp[i] = max(dp[i], dp[i - j] * 10 + j);
                }
            }
        }
        if (dp[target] == -1) return "0";
        string result;
        while (dp[target] > 0) {
            result.push_back('0' + dp[target] % 10);
            target = dp[target] / 10;
        }
        reverse(result.begin(), result.end());
        return result;
    }
};