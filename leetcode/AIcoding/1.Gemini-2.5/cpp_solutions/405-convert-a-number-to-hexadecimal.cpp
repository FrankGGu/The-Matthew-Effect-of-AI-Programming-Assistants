#include <string>
#include <algorithm>

class Solution {
public:
    std::string toHex(int num) {
        if (num == 0) {
            return "0";
        }

        std::string hexDigits = "0123456789abcdef";
        std::string result = "";

        unsigned int unum = num; 

        while (unum > 0) {
            int digit = unum & 0xF; 
            result += hexDigits[digit];
            unum >>= 4; 
        }

        std::reverse(result.begin(), result.end());

        return result;
    }
};