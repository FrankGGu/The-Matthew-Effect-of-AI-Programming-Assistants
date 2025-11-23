#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> replaceNonCoprimeNumbers(std::vector<int>& nums) {
        std::vector<int> result;
        for (int num : nums) {
            if (result.empty()) {
                result.push_back(num);
            } else {
                int g = std::gcd(result.back(), num);
                num = g > 1 ? std::lcm(result.back(), num) : num;
                while (!result.empty() && std::gcd(result.back(), num) > 1) {
                    num = std::lcm(result.back(), num);
                    result.pop_back();
                }
                result.push_back(num);
            }
        }
        return result;
    }
};