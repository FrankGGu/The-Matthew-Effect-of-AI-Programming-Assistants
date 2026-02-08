#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int longestPrefixOfSuffix(const string& s) {
        int n = s.length();
        vector<int> lps(n, 0);
        int len = 0;
        for (int i = 1; i < n; ) {
            if (s[i] == s[len]) {
                len++;
                lps[i] = len;
                i++;
            } else {
                if (len != 0) {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps[n - 1];
    }

    string longestHappyPrefix(string s) {
        int maxLen = longestPrefixOfSuffix(s);
        return s.substr(0, maxLen);
    }
};