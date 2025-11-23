#include <string>
#include <algorithm>

class Solution {
public:
    bool isRationalEqual(std::string s, std::string t) {
        return normalize(s) == normalize(t);
    }

private:
    double normalize(std::string s) {
        size_t dotPos = s.find('.');
        if (dotPos == std::string::npos) {
            return std::stod(s);
        }

        std::string integerPart = s.substr(0, dotPos);
        std::string fractionalPart = s.substr(dotPos + 1);

        size_t repeatPos = fractionalPart.find('(');
        if (repeatPos == std::string::npos) {
            return std::stod(s);
        }

        std::string nonRepeatingPart = fractionalPart.substr(0, repeatPos);
        std::string repeatingPart = fractionalPart.substr(repeatPos + 1, fractionalPart.length() - repeatPos - 2);

        double result = std::stod(integerPart);
        double nonRepeatingValue = 0.0;
        if (!nonRepeatingPart.empty()) {
            nonRepeatingValue = std::stod("0." + nonRepeatingPart);
        }

        double repeatingValue = 0.0;
        if (!repeatingPart.empty()) {
            repeatingValue = std::stod("0." + repeatingPart) / (pow(10, repeatingPart.length()) - 1);
        }

        for(int i = 0; i < nonRepeatingPart.length(); i++) {
            repeatingValue /= 10;
        }

        return result + nonRepeatingValue + repeatingValue;
    }
};