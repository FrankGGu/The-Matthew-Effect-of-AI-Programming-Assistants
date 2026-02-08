#include <string>
#include <vector>
#include <map>
#include <cctype> // For isdigit

class Solution {
public:
    std::string expr_str;
    int current_pos;
    std::vector<std::map<std::string, int>> scopes;

    void skip_spaces() {
        while (current_pos < expr_str.length() && expr_str[current_pos] == ' ') {
            current_pos++;
        }
    }

    int get_var_value(const std::string& var_name) {
        for (int i = scopes.size() - 1; i >= 0; --i) {
            if (scopes[i].count(var_name)) {
                return scopes[i][var_name];
            }
        }
        return 0; 
    }

    std::string parse_token() {
        int start = current_pos;
        while (current_pos < expr_str.length() && expr_str[current_pos] != ' ' && expr_str[current_pos] != ')') {
            current_pos++;
        }
        return expr_str.substr(start, current_pos - start);
    }

    int evaluate_expression() {
        skip_spaces();

        char first_char = expr_str[current_pos];

        if (isdigit(first_char) || first_char == '-') {
            int start = current_pos;
            while (current_pos < expr_str.length() && (isdigit(expr_str[current_pos]) || (expr_str[current_pos] == '-' && current_pos == start))) {
                current_pos++;
            }
            return std::stoi(expr_str.substr(start, current_pos - start));
        }

        if (first_char == '(') {
            current_pos++; 
            skip_spaces();

            std::string command = parse_token();
            skip_spaces();

            if (command == "let") {
                scopes.push_back({}); 
                std::map<std::string, int>& current_scope = scopes.back();
                int result = 0;

                while (true) {
                    skip_spaces();

                    int temp_pos = current_pos;
                    std::string next_token_str = parse_token();
                    current_pos = temp_pos; 

                    if (next_token_str[0] == '(' || isdigit(next_token_str[0]) || (next_token_str.length() > 1 && next_token_str[0] == '-' && isdigit(next_token_str[1]))) {
                        result = evaluate_expression();
                        current_pos++; 
                        break;
                    } else {
                        std::string var_name = parse_token();
                        skip_spaces();
                        int var_value = evaluate_expression();
                        current_scope[var_name] = var_value;
                        skip_spaces();
                    }
                }
                scopes.pop_back(); 
                return result;
            } else if (command == "add") {
                int val1 = evaluate_expression();
                skip_spaces();
                int val2 = evaluate_expression();
                current_pos++; 
                return val1 + val2;
            } else if (command == "mult") {
                int val1 = evaluate_expression();
                skip_spaces();
                int val2 = evaluate_expression();
                current_pos++; 
                return val1 * val2;
            }
        }

        std::string var_name = parse_token();
        return get_var_value(var_name);
    }

public:
    int evaluate(std::string expression) {
        expr_str = expression;
        current_pos = 0;
        scopes.clear();
        scopes.push_back({}); 

        return evaluate_expression();
    }
};