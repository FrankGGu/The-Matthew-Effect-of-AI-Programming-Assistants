class Solution {
public:
    string solveEquation(string equation) {
        int left = 0, right = 0, xCount = 0, numCount = 0, sign = 1, n = equation.size();

        for (int i = 0; i < n; ++i) {
            if (equation[i] == '+' || equation[i] == '-') {
                if (equation[i] == '-') sign = -1;
                else sign = 1;
            } else if (equation[i] == 'x') {
                xCount += sign * (i > 0 && isdigit(equation[i - 1]) ? (equation[i - 1] - '0') : 1);
                sign = 1;
            } else if (isdigit(equation[i])) {
                int num = 0;
                while (i < n && isdigit(equation[i])) {
                    num = num * 10 + (equation[i] - '0');
                    ++i;
                }
                --i;
                numCount += sign * num;
                sign = 1;
            }
        }

        left = numCount;
        sign = 1;
        for (int i = 0; i < n; ++i) {
            if (equation[i] == '=') {
                sign = -1;
                i++;
                break;
            }
        }

        for (; i < n; ++i) {
            if (equation[i] == '+' || equation[i] == '-') {
                if (equation[i] == '-') sign = -1;
                else sign = 1;
            } else if (equation[i] == 'x') {
                xCount -= sign * (i > 0 && isdigit(equation[i - 1]) ? (equation[i - 1] - '0') : 1);
                sign = 1;
            } else if (isdigit(equation[i])) {
                int num = 0;
                while (i < n && isdigit(equation[i])) {
                    num = num * 10 + (equation[i] - '0');
                    ++i;
                }
                --i;
                numCount -= sign * num;
                sign = 1;
            }
        }

        if (xCount == 0) {
            return numCount == 0 ? "Infinite solutions" : "No solution";
        }

        return "x=" + to_string(numCount / xCount);
    }
};