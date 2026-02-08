#include <numeric>
#include <string>

class Solution {
public:
    int gcd(int a, int b) {
        return b == 0 ? a : gcd(b, a % b);
    }

    std::string fractionAddition(std::string expression) {
        int num = 0, den = 1;
        int i = 0;
        while (i < expression.length()) {
            int sign = 1;
            if (expression[i] == '+' || expression[i] == '-') {
                if (expression[i] == '-') sign = -1;
                i++;
            }
            int num1 = 0;
            while (i < expression.length() && isdigit(expression[i])) {
                num1 = num1 * 10 + (expression[i] - '0');
                i++;
            }
            i++; 
            int den1 = 0;
            while (i < expression.length() && isdigit(expression[i])) {
                den1 = den1 * 10 + (expression[i] - '0');
                i++;
            }
            num1 *= sign;
            int newNum = num * den1 + num1 * den;
            int newDen = den * den1;
            int common = gcd(abs(newNum), abs(newDen));
            num = newNum / common;
            den = newDen / common;
        }
        return std::to_string(num) + "/" + std::to_string(den);
    }
};