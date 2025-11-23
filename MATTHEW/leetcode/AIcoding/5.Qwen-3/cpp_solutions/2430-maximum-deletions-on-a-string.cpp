#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumDeletions(string s) {
        vector<int> dp(26, 0);
        for (char c : s) {
            int idx = c - 'a';
            dp[idx] = 1;
            for (int i = 0; i < idx; ++i) {
                if (dp[i] + 1 > dp[idx]) {
                    dp[idx] = dp[i] + 1;
                }
            }
        }
        return *max_element(dp.begin(), dp.end());
    }
};