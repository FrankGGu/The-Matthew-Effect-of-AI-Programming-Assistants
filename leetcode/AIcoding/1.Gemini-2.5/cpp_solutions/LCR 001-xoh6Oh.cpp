#include <limits>
#include <cmath>

class Solution {
public:
    int divide(int dividend, int divisor) {
        if (dividend == std::numeric_limits<int>::min() && divisor == -1) {
            return std::numeric_limits<int>::max();
        }

        bool is_negative = (dividend < 0) ^ (divisor < 0);

        long long abs_dividend = std::abs(static_cast<long long>(dividend));
        long long abs_divisor = std::abs(static_cast<long long>(divisor));

        long long quotient = 0;

        while (abs_dividend >= abs_divisor) {
            long long temp_divisor = abs_divisor;
            long long multiple = 1;
            while (abs_dividend >= (temp_divisor << 1)) {
                temp_divisor <<= 1;
                multiple <<= 1;
            }
            abs_dividend -= temp_divisor;
            quotient += multiple;
        }

        if (is_negative) {
            return -static_cast<int>(quotient);
        } else {
            return static_cast<int>(quotient);
        }
    }
};