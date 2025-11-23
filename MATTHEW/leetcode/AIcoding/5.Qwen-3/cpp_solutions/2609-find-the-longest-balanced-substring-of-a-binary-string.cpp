#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int longestBalancedSubstring(string s) {
        int maxLen = 0;
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            int zeros = 0;
            int ones = 0;
            for (int j = i; j < n; ++j) {
                if (s[j] == '0') {
                    zeros++;
                } else {
                    ones++;
                }
                if (zeros == ones) {
                    maxLen = max(maxLen, j - i + 1);
                }
            }
        }
        return maxLen;
    }
};