#include <string>
#include <numeric>
#include <cmath>

class Solution {
public:
    std::string fractionAddition(std::string expression) {
        long long res_num = 0;
        long long res_den = 1;

        int i = 0;
        int n = expression.length();

        while (i < n) {
            long long sign = 1;
            if (expression[i] == '-') {
                sign = -1;
                i++;
            } else if (expression[i] == '+') {
                i++;
            }

            long long num = 0;
            while (i < n && isdigit(expression[i])) {
                num = num * 10 + (expression[i] - '0');
                i++;
            }
            num *= sign;

            i++; // Skip '/'

            long long den = 0;
            while (i < n && isdigit(expression[i])) {
                den = den * 10 + (expression[i] - '0');
                i++;
            }

            res_num = res_num * den + num * res_den;
            res_den = res_den * den;

            long long common_divisor = std::gcd(std::abs(res_num), std::abs(res_den));
            res_num /= common_divisor;
            res_den /= common_divisor;
        }

        return std::to_string(res_num) + "/" + std::to_string(res_den);
    }
};