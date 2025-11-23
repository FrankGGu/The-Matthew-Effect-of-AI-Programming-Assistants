#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestRepeatedCharSubstring(string s) {
        int maxLen = 0;
        int n = s.length();
        for (int i = 0; i < n; ) {
            char c = s[i];
            int j = i;
            while (j < n && s[j] == c) {
                j++;
            }
            maxLen = max(maxLen, j - i);
            i = j;
        }
        return maxLen;
    }
};