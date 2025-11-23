#include <string>
#include <algorithm>

class Solution {
public:
    int maxPower(std::string s) {
        if (s.empty()) {
            return 0;
        }

        int max_len = 1;
        int current_len = 1;

        for (size_t i = 1; i < s.length(); ++i) {
            if (s[i] == s[i - 1]) {
                current_len++;
            } else {
                current_len = 1;
            }
            max_len = std::max(max_len, current_len);
        }

        return max_len;
    }
};