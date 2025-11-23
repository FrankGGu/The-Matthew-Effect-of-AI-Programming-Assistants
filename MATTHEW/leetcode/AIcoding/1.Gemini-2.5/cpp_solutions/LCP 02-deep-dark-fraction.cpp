#include <vector>

class Solution {
public:
    std::vector<int> deepDarkFraction(std::vector<int>& fraction) {
        if (fraction.empty()) {
            return {0, 1}; 
        }

        int n = fraction.size();
        long long numerator = fraction[n - 1];
        long long denominator = 1;

        for (int i = n - 2; i >= 0; --i) {
            long long temp_numerator = (long long)fraction[i] * numerator + denominator;
            long long temp_denominator = numerator;

            numerator = temp_numerator;
            denominator = temp_denominator;
        }

        return {(int)numerator, (int)denominator};
    }
};