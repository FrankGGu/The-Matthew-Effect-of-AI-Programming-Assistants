#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findIntegers(int n) {
        vector<int> dp(32, 0);
        dp[0] = 1;
        dp[1] = 2;
        for (int i = 2; i < 32; ++i) {
            dp[i] = dp[i - 1] + dp[i - 2];
        }
        int res = 0;
        int pre = 1;
        for (int i = 30; i >= 0; --i) {
            if (n & (1 << i)) {
                res += dp[i];
                if (pre == 1 && (n & (1 << (i - 1)))) {
                    return res;
                }
                pre = 1;
            } else {
                pre = 0;
            }
        }
        return res + 1;
    }
};