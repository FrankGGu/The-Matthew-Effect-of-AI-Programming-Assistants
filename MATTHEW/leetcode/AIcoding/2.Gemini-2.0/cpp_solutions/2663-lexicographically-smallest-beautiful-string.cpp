#include <string>

using namespace std;

class Solution {
public:
    string smallestBeautifulString(string s, int k) {
        int n = s.length();
        for (int i = n - 1; i >= 0; --i) {
            for (char c = s[i] + 1; c < 'a' + k; ++c) {
                if ((i > 0 && c == s[i - 1]) || (i > 1 && c == s[i - 2])) {
                    continue;
                }
                s[i] = c;
                for (int j = i + 1; j < n; ++j) {
                    for (char d = 'a'; d < 'a' + k; ++d) {
                        if ((j > 0 && d == s[j - 1]) || (j > 1 && d == s[j - 2])) {
                            continue;
                        }
                        s[j] = d;
                        break;
                    }
                }
                return s;
            }
        }
        return "";
    }
};