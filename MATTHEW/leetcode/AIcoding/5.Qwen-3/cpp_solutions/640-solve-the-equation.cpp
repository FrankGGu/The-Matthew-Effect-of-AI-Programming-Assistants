#include <iostream>
#include <vector>
#include <sstream>
#include <map>

using namespace std;

class Solution {
public:
    string solveEquation(string equation) {
        auto parse = [](string s) -> pair<int, int> {
            int x = 0, const_val = 0;
            int sign = 1;
            int i = 0;
            while (i < s.size()) {
                if (s[i] == '+') {
                    sign = 1;
                    ++i;
                } else if (s[i] == '-') {
                    sign = -1;
                    ++i;
                }
                int num = 0;
                bool is_num = false;
                while (i < s.size() && isdigit(s[i])) {
                    num = num * 10 + (s[i] - '0');
                    is_num = true;
                    ++i;
                }
                if (i < s.size() && s[i] == 'x') {
                    x += sign * (is_num ? num : 1);
                    ++i;
                } else {
                    const_val += sign * num;
                }
            }
            return {x, const_val};
        };

        size_t pos = equation.find('=');
        string left = equation.substr(0, pos);
        string right = equation.substr(pos + 1);

        pair<int, int> l = parse(left);
        pair<int, int> r = parse(right);

        int x_coeff = l.first - r.first;
        int const_val = r.second - l.second;

        if (x_coeff == 0 && const_val == 0) {
            return "Infinite solutions";
        } else if (x_coeff == 0) {
            return "No solution";
        } else {
            return "x=" + to_string(const_val / x_coeff);
        }
    }
};