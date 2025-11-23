#include <vector>
#include <numeric> // Required for std::gcd

class Solution {
public:
    std::vector<int> replaceNonCoprimes(std::vector<int>& nums) {
        std::vector<int> result;

        for (int num : nums) {
            // Push the current number onto the result stack
            result.push_back(num);

            // Keep merging as long as there are at least two elements
            // and the last two elements are not coprime
            while (result.size() >= 2) {
                // Retrieve the last two elements, casting to long long for safe LCM calculation
                long long top1_ll = result[result.size() - 2];
                long long top2_ll = result[result.size() - 1];

                // Calculate their greatest common divisor
                long long common_divisor = std::gcd(top1_ll, top2_ll);

                if (common_divisor > 1) {
                    // If they are not coprime (GCD > 1), replace them with their LCM
                    result.pop_back(); // Pop top2
                    result.pop_back(); // Pop top1

                    // Calculate LCM: (a * b) / gcd. Use (a / gcd) * b to prevent intermediate overflow.
                    long long new_lcm_ll = (top1_ll / common_divisor) * top2_ll;

                    // Push the new LCM back onto the stack.
                    // The problem asks for a vector<int>, implying the final LCM will fit in int.
                    result.push_back(static_cast<int>(new_lcm_ll));
                } else {
                    // If they are coprime (GCD == 1), stop merging and move to the next number
                    break;
                }
            }
        }

        return result;
    }
};