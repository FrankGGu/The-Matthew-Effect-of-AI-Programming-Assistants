#include <string>
#include <vector>

class Solution {
public:
    std::string smallestBeautifulString(std::string s, int k) {
        int n = s.length();

        for (int i = n - 1; i >= 0; --i) {
            for (char c = s[i] + 1; c < 'a' + k; ++c) {
                if ((i > 0 && c == s[i - 1]) || (i > 1 && c == s[i - 2])) {
                    continue;
                }

                s[i] = c;

                for (int j = i + 1; j < n; ++j) {
                    for (char fill_c = 'a'; fill_c < 'a' + k; ++fill_c) {
                        if ((j > 0 && fill_c == s[j - 1]) || (j > 1 && fill_c == s[j - 2])) {
                            continue;
                        }

                        s[j] = fill_c;
                        break;
                    }
                }

                return s;
            }
        }

        return "";
    }
};