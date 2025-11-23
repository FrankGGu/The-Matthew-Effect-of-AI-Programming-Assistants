#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int distinctSubseqAII(string s) {
        int mod = 1000000007;
        vector<long> dp(26, 0);
        long total = 1;
        for (char c : s) {
            long prev = total;
            total = (total * 2 - dp[c - 'a']) % mod;
            dp[c - 'a'] = prev;
        }
        return (int)(total - 1);
    }
};