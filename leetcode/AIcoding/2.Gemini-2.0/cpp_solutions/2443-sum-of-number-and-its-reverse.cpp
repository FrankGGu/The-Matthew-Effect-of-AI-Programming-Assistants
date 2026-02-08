#include <string>
#include <algorithm>

class Solution {
public:
    int reverseNum(int num) {
        std::string s = std::to_string(num);
        std::reverse(s.begin(), s.end());
        try {
            return std::stoi(s);
        } catch (const std::out_of_range& oor) {
            return 0;
        }
    }

    int sumOfNumberAndReverse(int num) {
        int count = 0;
        for (int i = 0; i <= num; ++i) {
            if (i + reverseNum(i) == num) {
                count++;
            }
        }
        return count;
    }
};