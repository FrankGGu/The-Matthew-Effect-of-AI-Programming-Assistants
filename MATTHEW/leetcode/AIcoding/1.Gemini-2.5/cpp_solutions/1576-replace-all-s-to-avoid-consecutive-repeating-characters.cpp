#include <string>

class Solution {
public:
    std::string modifyString(std::string s) {
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            if (s[i] == '?') {
                for (char ch = 'a'; ch <= 'c'; ++ch) {
                    bool ok = true;

                    if (i > 0 && s[i-1] == ch) {
                        ok = false;
                    }

                    if (i < n - 1 && s[i+1] == ch) {
                        ok = false;
                    }

                    if (ok) {
                        s[i] = ch;
                        break;
                    }
                }
            }
        }
        return s;
    }
};