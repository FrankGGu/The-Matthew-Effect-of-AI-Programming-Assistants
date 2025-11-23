#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string longestNiceSubstring(string s) {
        if (s.length() < 2) return "";

        for (int i = 0; i < s.length(); ++i) {
            bool lower[26] = {false};
            bool upper[26] = {false};

            for (int j = i; j < s.length(); ++j) {
                if (islower(s[j])) {
                    lower[s[j] - 'a'] = true;
                } else {
                    upper[s[j] - 'A'] = true;
                }
            }

            for (int j = i; j < s.length(); ++j) {
                if (islower(s[j])) {
                    if (!upper[s[j] - 'a']) {
                        string s1 = longestNiceSubstring(s.substr(i, j - i));
                        string s2 = longestNiceSubstring(s.substr(j + 1));
                        return s1.length() >= s2.length() ? s1 : s2;
                    }
                } else {
                    if (!lower[s[j] - 'A']) {
                        string s1 = longestNiceSubstring(s.substr(i, j - i));
                        string s2 = longestNiceSubstring(s.substr(j + 1));
                        return s1.length() >= s2.length() ? s1 : s2;
                    }
                }
            }

            return s;
        }
        return "";
    }
};