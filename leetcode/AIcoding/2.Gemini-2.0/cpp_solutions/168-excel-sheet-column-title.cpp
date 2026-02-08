#include <string>
#include <algorithm>

class Solution {
public:
    std::string convertToTitle(int n) {
        std::string result = "";
        while (n > 0) {
            n--;
            result += (char)('A' + n % 26);
            n /= 26;
        }
        std::reverse(result.begin(), result.end());
        return result;
    }
};