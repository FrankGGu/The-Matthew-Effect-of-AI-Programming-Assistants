#include <vector>
#include <algorithm> // Required for std::min

class Solution {
public:
    double calculateTax(std::vector<std::vector<int>>& brackets, int income) {
        double totalTax = 0.0;
        int prevUpper = 0;

        for (const auto& bracket : brackets) {
            int currentUpper = bracket[0];
            int percent = bracket[1];

            int taxableAmountInThisBracket = std::min(income, currentUpper) - prevUpper;

            if (taxableAmountInThisBracket > 0) {
                totalTax += static_cast<double>(taxableAmountInThisBracket) * percent / 100.0;
            }

            prevUpper = currentUpper;

            if (income <= currentUpper) {
                break;
            }
        }

        return totalTax;
    }
};