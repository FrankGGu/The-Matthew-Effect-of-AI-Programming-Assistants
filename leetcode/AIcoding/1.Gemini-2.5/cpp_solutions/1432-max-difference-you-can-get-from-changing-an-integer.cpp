#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDiff(int num) {
        string s = to_string(num);
        string a = s, b = s;

        for (char c = '0'; c <= '9'; ++c) {
            if (s[0] != c) {
                char replace = s[0];
                for (int i = 0; i < a.size(); ++i) {
                    if (a[i] == replace) {
                        a[i] = '9';
                    }
                }
                break;
            } else {
                a[0] = '9';
                 for (int i = 1; i < a.size(); ++i) {
                    if (a[i] == s[0]) {
                        a[i] = '9';
                    }
                }
                break;
            }
        }

        if (s[0] != '1') {
            char replace = s[0];
            for (int i = 0; i < b.size(); ++i) {
                if (b[i] == replace) {
                    b[i] = '1';
                }
            }
        } else {
            bool found = false;
            for (char c = '0'; c <= '9'; ++c)
            {
                if(c == '1') continue;
                for(int i = 1; i < b.size(); ++i)
                {
                    if(b[i] != '0' && b[i] != '1')
                    {
                        char replace = b[i];
                         for (int j = 0; j < b.size(); ++j) {
                            if (b[j] == replace) {
                                b[j] = '0';
                            }
                        }
                        found = true;
                        break;
                    }
                }
                if(found) break;
            }
        }

        return stoi(a) - stoi(b);
    }
};