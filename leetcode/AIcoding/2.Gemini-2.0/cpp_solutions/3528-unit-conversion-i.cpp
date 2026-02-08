#include <string>

class Solution {
public:
    double unitConversion(double value, std::string unit) {
        if (unit == "Celsius") {
            return value + 273.15;
        } else {
            return value - 273.15;
        }
    }
};