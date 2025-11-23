#include <vector>
#include <algorithm>
#include <string>

class Solution {
public:
    std::string largestInteger(int num) {
        std::vector<int> oddDigits, evenDigits;
        std::string numStr = std::to_string(num);

        for (char c : numStr) {
            int digit = c - '0';
            if (digit % 2 == 0) {
                evenDigits.push_back(digit);
            } else {
                oddDigits.push_back(digit);
            }
        }

        std::sort(oddDigits.rbegin(), oddDigits.rend());
        std::sort(evenDigits.rbegin(), evenDigits.rend());

        std::string result;
        for (char c : numStr) {
            int digit = c - '0';
            if (digit % 2 == 0) {
                result += std::to_string(evenDigits.back());
                evenDigits.pop_back();
            } else {
                result += std::to_string(oddDigits.back());
                oddDigits.pop_back();
            }
        }

        return result;
    }
};