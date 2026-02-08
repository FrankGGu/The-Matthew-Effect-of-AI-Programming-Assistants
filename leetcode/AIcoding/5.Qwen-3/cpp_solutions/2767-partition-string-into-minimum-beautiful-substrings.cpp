#include <iostream>
#include <vector>
#include <string>
#include <climits>

using namespace std;

class Solution {
public:
    int minNumberOfBeautifulSubstrings(string s) {
        int n = s.length();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (dp[j] != INT_MAX && isBeautiful(s.substr(j, i - j))) {
                    dp[i] = min(dp[i], dp[j] + 1);
                }
            }
        }

        return dp[n];
    }

private:
    bool isBeautiful(const string& s) {
        int num = 0;
        for (char c : s) {
            num = num * 2 + (c - '0');
        }
        return (num & (num - 1)) == 0;
    }
};