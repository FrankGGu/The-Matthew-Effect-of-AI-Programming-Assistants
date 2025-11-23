#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    int longestSubsequence(std::string s, int k) {
        std::reverse(s.begin(), s.end());
        int len = 0;
        long long val = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == '0') {
                len++;
            } else {
                if (len >= 30) {
                    continue;
                }
                long long p2 = 1LL << len;
                if (val + p2 <= k) {
                    val += p2;
                    len++;
                }
            }
        }
        return len;
    }
};