#include <string>
#include <algorithm>

class Solution {
public:
    std::string convertToBase7(int num) {
        if (num == 0) {
            return "0";
        }

        bool is_negative = false;
        if (num < 0) {
            is_negative = true;
            num = -num;
        }

        std::string result = "";
        while (num > 0) {
            result += std::to_string(num % 7);
            num /= 7;
        }

        std::reverse(result.begin(), result.end());

        if (is_negative) {
            result = "-" + result;
        }

        return result;
    }
};