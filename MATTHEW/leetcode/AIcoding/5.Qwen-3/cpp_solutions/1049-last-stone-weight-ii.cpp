#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int lastStoneWeightII(vector<int>& stones) {
        int total = 0;
        for (int stone : stones) {
            total += stone;
        }

        int target = total / 2;
        vector<bool> dp(target + 1, false);
        dp[0] = true;

        for (int stone : stones) {
            for (int i = target; i >= stone; --i) {
                if (dp[i - stone]) {
                    dp[i] = true;
                }
            }
        }

        for (int i = target; i >= 0; --i) {
            if (dp[i]) {
                return total - 2 * i;
            }
        }

        return 0;
    }
};