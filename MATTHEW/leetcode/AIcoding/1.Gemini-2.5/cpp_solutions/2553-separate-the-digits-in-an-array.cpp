#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<int> separateDigits(std::vector<int>& nums) {
        std::vector<int> result;
        for (int num : nums) {
            if (num == 0) {
                result.push_back(0);
                continue;
            }
            std::vector<int> current_digits;
            while (num > 0) {
                current_digits.push_back(num % 10);
                num /= 10;
            }
            std::reverse(current_digits.begin(), current_digits.end());
            for (int digit : current_digits) {
                result.push_back(digit);
            }
        }
        return result;
    }
};