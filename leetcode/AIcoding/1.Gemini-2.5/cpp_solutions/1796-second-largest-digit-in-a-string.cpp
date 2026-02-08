#include <string>
#include <algorithm>

class Solution {
public:
    int secondHighest(std::string s) {
        int first = -1;
        int second = -1;

        for (char c : s) {
            if (c >= '0' && c <= '9') {
                int digit = c - '0';
                if (digit > first) {
                    second = first;
                    first = digit;
                } else if (digit < first && digit > second) {
                    second = digit;
                }
            }
        }
        return second;
    }
};