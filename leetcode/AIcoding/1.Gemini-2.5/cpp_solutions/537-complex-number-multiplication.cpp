#include <string>
#include <vector>
#include <sstream>

class Solution {
public:
    std::string complexNumberMultiply(std::string num1, std::string num2) {
        int real1, imag1;
        int real2, imag2;

        size_t plus_pos1 = num1.find('+');
        real1 = std::stoi(num1.substr(0, plus_pos1));
        imag1 = std::stoi(num1.substr(plus_pos1 + 1, num1.length() - (plus_pos1 + 1) - 1));

        size_t plus_pos2 = num2.find('+');
        real2 = std::stoi(num2.substr(0, plus_pos2));
        imag2 = std::stoi(num2.substr(plus_pos2 + 1, num2.length() - (plus_pos2 + 1) - 1));

        int result_real = (real1 * real2) - (imag1 * imag2);
        int result_imag = (real1 * imag2) + (imag1 * real2);

        return std::to_string(result_real) + "+" + std::to_string(result_imag) + "i";
    }
};