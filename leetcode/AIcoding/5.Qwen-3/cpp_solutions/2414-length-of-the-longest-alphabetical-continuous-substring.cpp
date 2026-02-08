#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int longestAlphabeticalSubstring(string s) {
        int maxLen = 1;
        int currentLen = 1;

        for (int i = 1; i < s.length(); ++i) {
            if (s[i] > s[i - 1]) {
                currentLen++;
                maxLen = max(maxLen, currentLen);
            } else {
                currentLen = 1;
            }
        }

        return maxLen;
    }
};