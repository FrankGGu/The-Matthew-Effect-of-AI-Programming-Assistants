#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    std::vector<std::string> simplifiedFractions(int n) {
        std::vector<std::string> result;
        for (int denominator = 2; denominator <= n; ++denominator) {
            for (int numerator = 1; numerator < denominator; ++numerator) {
                if (std::gcd(numerator, denominator) == 1) {
                    result.push_back(std::to_string(numerator) + "/" + std::to_string(denominator));
                }
            }
        }
        return result;
    }
};