#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string lexSmallestBeautifulString(string s) {
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            if (i > 0 && s[i] == s[i - 1]) continue;
            if (i > 1 && s[i] == s[i - 2]) continue;
            char original = s[i];
            for (char c = 'a'; c <= 'z'; ++c) {
                if (i > 0 && c == s[i - 1]) continue;
                if (i > 1 && c == s[i - 2]) continue;
                s[i] = c;
                string res = lexSmallestBeautifulString(s);
                if (res != "") return res;
            }
            s[i] = original;
            return "";
        }
        return s;
    }
};