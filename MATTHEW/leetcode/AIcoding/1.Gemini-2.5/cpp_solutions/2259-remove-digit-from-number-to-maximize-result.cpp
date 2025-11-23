#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    std::string removeDigit(std::string number, char digit) {
        std::string max_result_str = "";
        int n = number.length();

        for (int i = 0; i < n; ++i) {
            if (number[i] == digit) {
                std::string current_result_str = number.substr(0, i) + number.substr(i + 1);
                if (max_result_str == "" || current_result_str > max_result_str) {
                    max_result_str = current_result_str;
                }
            }
        }
        return max_result_str;
    }
};