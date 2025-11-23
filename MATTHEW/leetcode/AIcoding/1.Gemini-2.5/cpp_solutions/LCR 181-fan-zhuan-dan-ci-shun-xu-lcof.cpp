#include <string>
#include <algorithm>

class Solution {
public:
    std::string reverseWords(std::string s) {
        int n = s.length();
        int i = 0, j = 0;

        while (i < n && s[i] == ' ') {
            i++;
        }

        while (i < n) {
            if (s[i] == ' ') {
                if (j > 0 && s[j-1] != ' ') { 
                    s[j++] = ' ';
                }
            } else {
                s[j++] = s[i];
            }
            i++;
        }

        if (j > 0 && s[j-1] == ' ') {
            j--;
        }

        s.resize(j);

        if (s.empty()) {
            return s;
        }

        std::reverse(s.begin(), s.end());

        int word_start = 0;
        int current_len = s.length();
        for (int k = 0; k < current_len; ++k) {
            if (s[k] == ' ') {
                std::reverse(s.begin() + word_start, s.begin() + k);
                word_start = k + 1;
            }
        }
        std::reverse(s.begin() + word_start, s.end());

        return s;
    }
};