#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> findSubstringInWrapall(string& s) {
        vector<int> result;
        int n = s.length();
        vector<int> dp(n, 1);

        for (int i = 1; i < n; ++i) {
            if (s[i] - s[i - 1] == 1) {
                dp[i] = dp[i - 1] + 1;
            }
        }

        for (int i = 0; i < n; ++i) {
            result.push_back(dp[i]);
        }

        return result;
    }
};