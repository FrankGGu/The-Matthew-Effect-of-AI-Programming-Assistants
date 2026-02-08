#include <string>

class Solution {
public:
    std::string lastSubstring(std::string s) {
        int n = s.length();
        if (n == 0) {
            return "";
        }

        int i = 0, j = 1, k = 0;

        while (j + k < n) {
            if (s[i + k] == s[j + k]) {
                k++;
            } else if (s[i + k] < s[j + k]) {
                i = j;
                j = i + 1;
                k = 0;
            } else { // s[i + k] > s[j + k]
                j = j + k + 1;
                k = 0;
            }
        }

        return s.substr(i);
    }
};