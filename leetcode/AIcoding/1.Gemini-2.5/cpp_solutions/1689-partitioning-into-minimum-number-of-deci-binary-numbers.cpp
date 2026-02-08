#include <string>
#include <algorithm>

class Solution {
public:
    int minPartitions(std::string n) {
        char max_digit = '0';
        for (char c : n) {
            if (c > max_digit) {
                max_digit = c;
            }
        }
        return max_digit - '0';
    }
};