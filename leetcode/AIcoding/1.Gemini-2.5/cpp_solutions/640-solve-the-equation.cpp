#include <string>
#include <vector>
#include <utility>
#include <cctype>

class Solution {
public:
    std::pair<int, int> parseSide(const std::string& s) {
        int x_coeff = 0;
        int constant = 0;
        int n = s.length();
        int i = 0;

        while (i < n) {
            int sign = 1;
            if (s[i] == '+') {
                i++;
            } else if (s[i] == '-') {
                sign = -1;
                i++;
            }

            int num = 0;
            bool is_num_parsed = false;
            int j = i;
            while (j < n && std::isdigit(s[j])) {
                num = num * 10 + (s[j] - '0');
                j++;
                is_num_parsed = true;
            }

            if (j < n && s[j] == 'x') {
                if (!is_num_parsed) {
                    x_coeff += sign;
                } else {
                    x_coeff += sign * num;
                }
                i = j + 1;
            } else {
                if (is_num_parsed) {
                    constant += sign * num;
                }
                i = j;
            }
        }
        return {x_coeff, constant};
    }

    std::string solveEquation(std::string equation) {
        size_t equal_pos = equation.find('=');
        std::string left_str = equation.substr(0, equal_pos);
        std::string right_str = equation.substr(equal_pos + 1);

        std::pair<int, int> left_side = parseSide(left_str);
        std::pair<int, int> right_side = parseSide(right_str);

        int total_x_coeff = left_side.first - right_side.first;
        int total_constant = right_side.second - left_side.second;

        if (total_x_coeff == 0) {
            if (total_constant == 0) {
                return "Infinite solutions";
            } else {
                return "No solution";
            }
        } else {
            return "x=" + std::to_string(total_constant / total_x_coeff);
        }
    }
};