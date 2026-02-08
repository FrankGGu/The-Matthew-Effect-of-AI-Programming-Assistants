#include <string>
#include <algorithm>
#include <limits>

class Solution {
public:
    std::string minimizeResult(std::string expression) {
        size_t plus_idx = expression.find('+');

        long long min_val = std::numeric_limits<long long>::max();
        std::string min_expression = "";

        for (int i = 0; i < plus_idx; ++i) {
            for (int j = plus_idx + 1; j < expression.length(); ++j) {

                std::string left_multiplier_str = expression.substr(0, i);
                std::string left_addend_str = expression.substr(i, plus_idx - i);
                std::string right_addend_str = expression.substr(plus_idx + 1, j - (plus_idx + 1) + 1);
                std::string right_multiplier_str = expression.substr(j + 1);

                long long left_multiplier = left_multiplier_str.empty() ? 1 : std::stoll(left_multiplier_str);
                long long left_addend = std::stoll(left_addend_str);
                long long right_addend = std::stoll(right_addend_str);
                long long right_multiplier = right_multiplier_str.empty() ? 1 : std::stoll(right_multiplier_str);

                long long current_val = left_multiplier * (left_addend + right_addend) * right_multiplier;

                if (current_val < min_val) {
                    min_val = current_val;

                    min_expression = left_multiplier_str;
                    min_expression += "(";
                    min_expression += left_addend_str;
                    min_expression += "+";
                    min_expression += right_addend_str;
                    min_expression += ")";
                    min_expression += right_multiplier_str;
                }
            }
        }

        return min_expression;
    }
};