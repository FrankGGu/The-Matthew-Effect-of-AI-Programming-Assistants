#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool canMakeAStringSubsequence(string s, string t) {
        int n = s.size(), m = t.size();
        int i = 0, j = 0;
        while (i < n && j < m) {
            if (s[i] == t[j] || (s[i] + 1 - 'a') % 26 + 'a' == t[j]) {
                i++;
                j++;
            } else {
                i++;
            }
        }
        return j == m;
    }
};