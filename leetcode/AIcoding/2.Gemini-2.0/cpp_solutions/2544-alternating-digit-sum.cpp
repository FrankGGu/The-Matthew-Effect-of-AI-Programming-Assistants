#include <string>

class Solution {
public:
    int alternateDigitSum(int n) {
        std::string s = std::to_string(n);
        int sum = 0;
        int sign = 1;
        for (char c : s) {
            sum += sign * (c - '0');
            sign *= -1;
        }
        return sum;
    }
};