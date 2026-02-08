#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int divide(int dividend, int divisor) {
        if (dividend == INT_MIN && divisor == -1) {
            return INT_MAX;
        }
        long long a = abs(dividend);
        long long b = abs(divisor);
        int result = 0;
        while (a >= b) {
            long long temp = b;
            long long i = 1;
            while (a >= temp) {
                temp <<= 1;
                i <<= 1;
            }
            a -= temp >> 1;
            result += i >> 1;
        }
        return (dividend > 0) == (divisor > 0) ? result : -result;
    }
};