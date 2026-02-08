#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    std::string baseNeg2(int n) {
        if (n == 0) {
            return "0";
        }
        std::string res;
        while (n != 0) {
            int remainder = n & 1;
            res += (remainder == 0 ? '0' : '1');
            n = -(n >> 1);
        }
        std::reverse(res.begin(), res.end());
        return res;
    }
};