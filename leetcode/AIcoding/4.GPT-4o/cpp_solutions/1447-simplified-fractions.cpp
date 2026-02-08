#include <vector>
#include <numeric>
#include <string>

class Solution {
public:
    std::vector<std::string> simplifiedFractions(int n) {
        std::vector<std::string> result;
        for (int numerator = 1; numerator < n; ++numerator) {
            for (int denominator = numerator + 1; denominator <= n; ++denominator) {
                if (std::gcd(numerator, denominator) == 1) {
                    result.push_back(std::to_string(numerator) + "/" + std::to_string(denominator));
                }
            }
        }
        return result;
    }
};