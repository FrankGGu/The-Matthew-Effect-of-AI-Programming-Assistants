#include <string>
#include <numeric>

class Solution {
public:
    std::string gcdOfStrings(std::string str1, std::string str2) {
        if (str1 + str2 != str2 + str1) {
            return "";
        }
        int len1 = str1.length();
        int len2 = str2.length();
        int gcd_len = std::gcd(len1, len2);
        return str1.substr(0, gcd_len);
    }
};