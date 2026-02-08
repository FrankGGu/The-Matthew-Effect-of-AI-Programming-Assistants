#include <string>
#include <unordered_map>
#include <vector>
#include <cmath>
#include <cstdlib>

class Solution {
public:
    std::string fractionToDecimal(int numerator, int denominator) {
        if (numerator == 0) {
            return "0";
        }

        std::string res;
        if ((numerator < 0) ^ (denominator < 0)) {
            res += "-";
        }

        long long num = std::abs(static_cast<long long>(numerator));
        long long den = std::abs(static_cast<long long>(denominator));

        res += std::to_string(num / den);
        long long remainder = num % den;

        if (remainder == 0) {
            return res;
        }

        res += ".";
        std::unordered_map<long long, int> remainder_map;

        while (remainder != 0) {
            if (remainder_map.count(remainder)) {
                res.insert(remainder_map[remainder], "(");
                res += ")";
                break;
            }

            remainder_map[remainder] = res.length();
            remainder *= 10;
            res += std::to_string(remainder / den);
            remainder %= den;
        }

        return res;
    }
};