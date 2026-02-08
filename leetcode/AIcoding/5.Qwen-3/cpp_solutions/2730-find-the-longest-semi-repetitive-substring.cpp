#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int longestSemiRepetitiveSubstring(string s) {
        int n = s.length();
        int maxLen = 1;
        for (int i = 0; i < n; ++i) {
            int count = 0;
            for (int j = i + 1; j < n; ++j) {
                if (s[j] == s[j - 1]) {
                    count++;
                }
                if (count <= 1) {
                    maxLen = max(maxLen, j - i + 1);
                } else {
                    break;
                }
            }
        }
        return maxLen;
    }
};