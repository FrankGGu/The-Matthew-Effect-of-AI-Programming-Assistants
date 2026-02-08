#include <string>

using namespace std;

class Solution {
public:
    string modifyString(string s) {
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            if (s[i] == '?') {
                for (char c = 'a'; c <= 'c'; ++c) {
                    bool valid = true;
                    if (i > 0 && s[i - 1] == c) {
                        valid = false;
                    }
                    if (i < n - 1 && s[i + 1] != '?' && s[i + 1] == c) {
                        valid = false;
                    }
                    if (valid) {
                        s[i] = c;
                        break;
                    }
                }
            }
        }
        return s;
    }
};