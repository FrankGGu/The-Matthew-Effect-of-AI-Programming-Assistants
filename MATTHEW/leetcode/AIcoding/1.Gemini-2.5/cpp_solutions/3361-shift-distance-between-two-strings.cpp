#include <string>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int shiftDistance(std::string s, std::string t) {
        if (s.length() != t.length()) {
            return -1;
        }

        if (s == t) {
            return 0;
        }

        std::string s_double = s + s;
        size_t found_pos = s_double.find(t);

        if (found_pos == std::string::npos) {
            return -1;
        } else {
            return static_cast<int>(found_pos);
        }
    }
};