#include <iostream>
#include <string>

class Solution {
public:
    std::string removeTrailingZeros(std::string num) {
        int i = num.length() - 1;
        while (i >= 0 && num[i] == '0') {
            i--;
        }
        return num.substr(0, i + 1);
    }
};