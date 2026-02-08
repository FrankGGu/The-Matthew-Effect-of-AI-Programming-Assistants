#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minimumSum(int num) {
        vector<int> dp(num + 1, 0);
        for (int i = 1; i <= num; ++i) {
            dp[i] = i;
            for (int j = 1; j < i; ++j) {
                if (i - j >= 0 && (i - j) % 10 == 0) {
                    dp[i] = min(dp[i], dp[j] + dp[i - j]);
                }
            }
        }
        return dp[num];
    }
};