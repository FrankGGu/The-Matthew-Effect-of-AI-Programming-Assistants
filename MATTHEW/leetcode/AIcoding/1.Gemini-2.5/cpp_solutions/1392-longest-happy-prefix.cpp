#include <string>
#include <vector>

class Solution {
public:
    std::string longestPrefix(std::string s) {
        int n = s.length();
        if (n == 0) {
            return "";
        }

        std::vector<int> lps(n, 0);
        int length = 0;
        int i = 1;

        while (i < n) {
            if (s[i] == s[length]) {
                length++;
                lps[i] = length;
                i++;
            } else {
                if (length != 0) {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }

        int len_lhp = lps[n - 1];
        return s.substr(0, len_lhp);
    }
};