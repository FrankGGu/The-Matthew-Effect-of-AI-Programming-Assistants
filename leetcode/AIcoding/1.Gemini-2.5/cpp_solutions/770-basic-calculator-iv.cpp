#include <string>
#include <vector>
#include <map>
#include <algorithm>
#include <sstream>
#include <cctype>

struct Poly {
    std::map<std::vector<std::string>, int> terms;

    Poly() = default;

    Poly(int val) {
        if (val != 0) {
            terms[{}] = val;
        }
    }

    Poly(const std::string& var) {
        terms[{var}] = 1;
    }

    Poly operator+(const Poly& other) const {
        Poly result = *this;
        for (const auto& p : other.terms) {
            result.terms[p.first] += p.second;
            if (result.terms[p.first] == 0) {
                result.terms.erase(p.first);
            }
        }
        return result;
    }

    Poly operator-(const Poly& other) const {
        Poly result = *this;
        for (const auto& p : other.terms) {
            result.terms[p.first] -= p.second;
            if (result.terms[p.first] == 0) {
                result.terms.erase(p.first);
            }
        }
        return result;
    }

    Poly operator*(const Poly& other) const {
        Poly result;
        for (const auto& p1 : terms) {
            for (const auto& p2 : other.terms) {
                std::vector<std::string> new_vars = p1.first;
                new_vars.insert(new_vars.end(), p2.first.begin(), p2.first.end());
                std::sort(new_vars.begin(), new_vars.end());

                int new_coeff = p1.second * p2.second;
                if (new_coeff != 0) {
                    result.terms[new_vars] += new_coeff;
                    if (result.terms[new_vars] == 0) {
                        result.terms.erase(new_vars);
                    }
                }
            }
        }
        return result;
    }

    std::vector<std::string> toStringList() const {
        std::vector<std::pair<std::vector<std::string>, int>> sorted_terms;
        for (const auto& p : terms) {
            sorted_terms.push_back(p);
        }

        std::sort(sorted_terms.begin(), sorted_terms.end(), [](const auto& a, const auto& b) {
            if (a.first.size() != b.first.size()) {
                return a.first.size() > b.first.size();
            }
            for (size_t i = 0; i < a.first.size(); ++i) {
                if (a.first[i] != b.first[i]) {
                    return a.first[i] < b.first[i];
                }
            }
            return false;
        });

        std::vector<std::string> result_list;
        for (const auto& p : sorted_terms) {
            std::string term_str = std::to_string(p.second);
            for (const std::string& var : p.first) {
                term_str += "*" + var;
            }
            result_list.push_back(term_str);
        }
        return result_list;
    }
};

class Parser {
public:
    Parser(const std::string& expr, const std::map<std::string, int>& var_values)
        : expression(expr), pos(0), var_values_map(var_values) {}

    Poly parse() {
        return parseExpression();
    }

private:
    std::string expression;
    size_t pos;
    const std::map<std::string, int>& var_values_map;

    void skipWhitespace() {
        while (pos < expression.length() && expression[pos] == ' ') {
            pos++;
        }
    }

    Poly parseExpression() {
        Poly result = parseTerm();
        skipWhitespace();
        while (pos < expression.length() && (expression[pos] == '+' || expression[pos] == '-')) {
            char op = expression[pos];
            pos++;
            skipWhitespace();
            Poly next_term = parseTerm();
            if (op == '+') {
                result = result + next_term;
            } else {
                result = result - next_term;
            }
            skipWhitespace();
        }
        return result;
    }

    Poly parseTerm() {
        Poly result = parseFactor();
        skipWhitespace();
        while (pos < expression.length() && expression[pos] == '*') {
            pos++;
            skipWhitespace();
            Poly next_factor = parseFactor();
            result = result * next_factor;
            skipWhitespace();
        }
        return result;
    }

    Poly parseFactor() {
        skipWhitespace();
        if (expression[pos] == '(') {
            pos++;
            Poly result = parseExpression();
            pos++;
            return result;
        } else if (isdigit(expression[pos])) {
            return parseNumber();
        } else {
            return parseVariable();
        }
    }

    Poly parseNumber() {
        size_t start_pos = pos;
        while (pos < expression.length() && isdigit(expression[pos])) {
            pos++;
        }
        int num = std::stoi(expression.substr(start_pos, pos - start_pos));
        return Poly(num);
    }

    Poly parseVariable() {
        size_t start_pos = pos;
        while (pos < expression.length() && isalpha(expression[pos])) {
            pos++;
        }
        std::string var_name = expression.substr(start_pos, pos - start_pos);

        if (var_values_map.count(var_name)) {
            return Poly(var_values_map.at(var_name));
        } else {
            return Poly(var_name);
        }
    }
};

class Solution {
public:
    std::vector<std::string> basicCalculatorIV(std::string expression, std::vector<std::string>& evalvars, std::vector<int>& evalints) {
        std::map<std::string, int> var_values;
        for (size_t i = 0; i < evalvars.size(); ++i) {
            var_values[evalvars[i]] = evalints[i];
        }

        Parser parser(expression, var_values);
        Poly result_poly = parser.parse();

        return result_poly.toStringList();
    }
};