#include <string>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int numDifferentIntegers(std::string word) {
        std::unordered_set<std::string> uniqueNumbers;
        std::string currentNum;

        for (char c : word) {
            if (isdigit(c)) {
                currentNum += c;
            } else {
                if (!currentNum.empty()) {
                    // Remove leading zeros
                    size_t firstDigit = 0;
                    while (firstDigit < currentNum.length() - 1 && currentNum[firstDigit] == '0') {
                        firstDigit++;
                    }
                    uniqueNumbers.insert(currentNum.substr(firstDigit));
                    currentNum.clear();
                }
            }
        }

        // Handle the last number if the string ends with a digit
        if (!currentNum.empty()) {
            size_t firstDigit = 0;
            while (firstDigit < currentNum.length() - 1 && currentNum[firstDigit] == '0') {
                firstDigit++;
            }
            uniqueNumbers.insert(currentNum.substr(firstDigit));
        }

        return uniqueNumbers.size();
    }
};