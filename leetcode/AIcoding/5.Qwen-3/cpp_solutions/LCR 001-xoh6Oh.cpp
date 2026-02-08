#include <iostream>
#include <vector>

class Solution {
public:
    int divide(int dividend, int divisor) {
        if (dividend == INT_MIN && divisor == -1) {
            return INT_MAX;
        }
        int sign = (dividend < 0) ^ (divisor < 0) ? -1 : 1;
        long long a = labs(dividend);
        long long b = labs(divisor);
        int result = 0;
        while (a >= b) {
            long long temp = b;
            long long multiple = 1;
            while (a >= (temp << 1)) {
                temp <<= 1;
                multiple <<= 1;
            }
            a -= temp;
            result += multiple;
        }
        return sign == 1 ? result : -result;
    }
};