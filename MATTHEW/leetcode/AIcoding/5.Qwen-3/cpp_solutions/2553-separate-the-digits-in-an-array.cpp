#include <iostream>
#include <vector>

class Solution {
public:
    std::vector<int> separateDigits(std::vector<int>& nums) {
        std::vector<int> result;
        for (int num : nums) {
            std::vector<int> digits;
            int temp = num;
            while (temp > 0) {
                digits.push_back(temp % 10);
                temp /= 10;
            }
            for (int i = digits.size() - 1; i >= 0; --i) {
                result.push_back(digits[i]);
            }
        }
        return result;
    }
};