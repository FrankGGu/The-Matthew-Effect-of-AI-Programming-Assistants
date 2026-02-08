#include <string>
#include <vector>
#include <set>
#include <algorithm>

class Solution {
public:
    std::set<std::string> unionSets(const std::set<std::string>& s1, const std::set<std::string>& s2) {
        std::set<std::string> result = s1;
        for (const std::string& str : s2) {
            result.insert(str);
        }
        return result;
    }

    std::set<std::string> productSets(const std::set<std::string>& s1, const std::set<std::string>& s2) {
        std::set<std::string> result;
        for (const std::string& str1 : s1) {
            for (const std::string& str2 : s2) {
                result.insert(str1 + str2);
            }
        }
        return result;
    }

    std::set<std::string> parse(const std::string& expression, int& pos) {
        std::set<std::string> union_result;
        std::set<std::string> current_product_accumulator;
        current_product_accumulator.insert("");

        while (pos < expression.length()) {
            char current_char = expression[pos];

            if (current_char == ',') {
                union_result = unionSets(union_result, current_product_accumulator);
                current_product_accumulator.clear();
                current_product_accumulator.insert("");
                pos++;
            } else if (current_char == '}') {
                break;
            } else if (current_char == '{') {
                pos++;
                std::set<std::string> inner_expression_result = parse(expression, pos);
                pos++;
                current_product_accumulator = productSets(current_product_accumulator, inner_expression_result);
            } else {
                std::set<std::string> char_set;
                char_set.insert(std::string(1, current_char));
                current_product_accumulator = productSets(current_product_accumulator, char_set);
                pos++;
            }
        }

        union_result = unionSets(union_result, current_product_accumulator);
        return union_result;
    }

    std::vector<std::string> braceExpansionII(std::string expression) {
        int pos = 0;
        std::set<std::string> result_set = parse(expression, pos);

        std::vector<std::string> result_vec(result_set.begin(), result_set.end());
        return result_vec;
    }
};