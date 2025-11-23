class Solution {
public:
    string solveEquation(string equation) {
        int n = equation.size();
        int coeff = 0, constTerm = 0;
        int sign = 1;
        int i = 0;

        for (int j = 0; j < 2; ++j) {
            if (equation[i] == '-') {
                sign = -1;
                ++i;
            } else {
                sign = 1;
            }

            while (i < n && equation[i] != '=') {
                int num = 0;
                bool hasNum = false;
                while (i < n && isdigit(equation[i])) {
                    num = num * 10 + (equation[i] - '0');
                    ++i;
                    hasNum = true;
                }

                if (i < n && equation[i] == 'x') {
                    if (!hasNum) num = 1;
                    coeff += sign * num;
                    ++i;
                } else {
                    constTerm += sign * num;
                }

                if (i < n && equation[i] == '+') {
                    sign = 1;
                    ++i;
                } else if (i < n && equation[i] == '-') {
                    sign = -1;
                    ++i;
                }
            }
            ++i;
            sign = -1;
        }

        if (coeff == 0) {
            if (constTerm == 0) {
                return "Infinite solutions";
            } else {
                return "No solution";
            }
        }

        int res = -constTerm / coeff;
        return "x=" + to_string(res);
    }
};