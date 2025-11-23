#include <string>

using namespace std;

class Solution {
public:
    string solveEquation(string equation) {
        int left_coef = 0, left_const = 0;
        int right_coef = 0, right_const = 0;

        int sign = 1;
        int num = 0;
        bool left = true;

        for (int i = 0; i < equation.length(); ++i) {
            char c = equation[i];

            if (c == '+') {
                if (left) left_const += sign * num;
                else right_const += sign * num;
                sign = 1;
                num = 0;
            } else if (c == '-') {
                if (left) left_const += sign * num;
                else right_const += sign * num;
                sign = -1;
                num = 0;
            } else if (c == '=') {
                if (left) left_const += sign * num;
                else right_const += sign * num;
                left = false;
                sign = 1;
                num = 0;
            } else if (c == 'x') {
                if (num == 0) num = 1;
                if (left) left_coef += sign * num;
                else right_coef += sign * num;
                num = 0;
                sign = 1;
            } else {
                num = num * 10 + (c - '0');
            }
        }

        if (left) left_const += sign * num;
        else right_const += sign * num;

        int coef = left_coef - right_coef;
        int constant = right_const - left_const;

        if (coef == 0) {
            if (constant == 0) return "Infinite solutions";
            else return "No solution";
        } else {
            return "x=" + to_string(constant / coef);
        }
    }
};