#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::string> get_valid_numbers(const std::string& s) {
        std::vector<std::string> res;
        if (s.empty()) {
            return res;
        }

        if (s.length() == 1 || s[0] != '0') {
            res.push_back(s);
        }

        for (int i = 1; i < s.length(); ++i) {
            std::string left_part = s.substr(0, i);
            std::string right_part = s.substr(i);

            bool left_part_valid = (left_part.length() == 1 || left_part[0] != '0');
            bool right_part_valid = (right_part[right_part.length() - 1] != '0');

            if (left_part_valid && right_part_valid) {
                res.push_back(left_part + "." + right_part);
            }
        }
        return res;
    }

    std::vector<std::string> ambiguousCoordinates(std::string s) {
        std::vector<std::string> result;
        std::string digits_str = s.substr(1, s.length() - 2);

        for (int i = 1; i < digits_str.length(); ++i) {
            std::string x_left_str = digits_str.substr(0, i);
            std::string x_right_str = digits_str.substr(i);

            std::vector<std::string> valid_left_parts = get_valid_numbers(x_left_str);
            std::vector<std::string> valid_right_parts = get_valid_numbers(x_right_str);

            for (const std::string& l_part : valid_left_parts) {
                for (const std::string& r_part : valid_right_parts) {
                    result.push_back("(" + l_part + ", " + r_part + ")");
                }
            }
        }
        return result;
    }
};