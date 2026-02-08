#include <iostream>
#include <vector>
#include <string>

class Solution {
public:
    int maxValue(std::vector<std::string>& strs) {
        int maxVal = 0;
        for (const std::string& s : strs) {
            bool isAllDigits = true;
            for (char c : s) {
                if (!isdigit(c)) {
                    isAllDigits = false;
                    break;
                }
            }
            if (isAllDigits) {
                int num = std::stoi(s);
                if (num > maxVal) {
                    maxVal = num;
                }
            }
        }
        return maxVal;
    }
};