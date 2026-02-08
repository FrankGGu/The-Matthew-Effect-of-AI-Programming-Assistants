#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countDistinctSubseqes(string s) {
        int mod = 1000000007;
        vector<int> dp(26, 0);
        int total = 1;
        for (int i = 0; i < s.length(); ++i) {
            int idx = s[i] - 'a';
            int prev = dp[idx];
            dp[idx] = (total + 1) % mod;
            total = (total + dp[idx] - prev) % mod;
        }
        return total;
    }
};