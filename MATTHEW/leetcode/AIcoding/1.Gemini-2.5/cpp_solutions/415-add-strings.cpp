#include <string>
#include <algorithm> // Required for std::reverse

class Solution {
public:
    std::string addStrings(std::string num1, std::string num2) {
        std::string result = "";
        int i = num1.length() - 1;
        int j = num2.length() - 1;
        int carry = 0;

        while (i >= 0 || j >= 0 || carry > 0) {
            int digit1 = (i >= 0) ? num1[i] - '0' : 0;
            int digit2 = (j >= 0) ? num2[j] - '0' : 0;

            int sum = digit1 + digit2 + carry;
            result += std::to_string(sum % 10);
            carry = sum / 10;

            i--;
            j--;
        }

        std::reverse(result.begin(), result.end());
        return result;
    }
};