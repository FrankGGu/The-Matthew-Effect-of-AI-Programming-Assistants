#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::string thousandSeparator(int n) {
        std::string s = std::to_string(n);
        int len = s.length();
        std::string result;
        for (int i = 0; i < len; ++i) {
            if ((len - i - 1) % 3 == 0 && i != 0) {
                result += '.';
            }
            result += s[i];
        }
        return result;
    }
};