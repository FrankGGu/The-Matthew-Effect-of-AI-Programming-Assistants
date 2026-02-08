#include <string>
#include <vector>
#include <algorithm> // For std::max
#include <cctype>    // For std::isdigit

class Solution {
public:
    int maximumValue(std::vector<std::string>& strs) {
        int max_val = 0;

        for (const std::string& s : strs) {
            bool is_numeric = true;
            for (char c : s) {
                if (!std::isdigit(c)) {
                    is_numeric = false;
                    break;
                }
            }

            if (is_numeric) {
                max_val = std::max(max_val, std::stoi(s));
            } else {
                max_val = std::max(max_val, (int)s.length());
            }
        }

        return max_val;
    }
};