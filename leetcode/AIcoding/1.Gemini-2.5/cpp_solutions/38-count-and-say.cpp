#include <string>
#include <vector>

class Solution {
public:
    std::string countAndSay(int n) {
        if (n == 1) {
            return "1";
        }

        std::string s = "1";

        for (int i = 2; i <= n; ++i) {
            std::string next_s;
            int count = 1;
            for (int j = 1; j <= s.length(); ++j) {
                if (j == s.length() || s[j] != s[j-1]) {
                    next_s += std::to_string(count);
                    next_s += s[j-1];
                    count = 1;
                } else {
                    count++;
                }
            }
            s = next_s;
        }

        return s;
    }
};