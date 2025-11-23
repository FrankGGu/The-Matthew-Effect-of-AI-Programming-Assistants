#include <string>
#include <algorithm> // Required for std::reverse

class Solution {
public:
    std::string thousandSeparator(int n) {
        if (n == 0) {
            return "0";
        }

        std::string s = std::to_string(n);
        std::string result = "";
        int count = 0; 

        for (int i = s.length() - 1; i >= 0; --i) {
            result += s[i];
            count++;
            if (count % 3 == 0 && i != 0) {
                result += '.';
            }
        }

        std::reverse(result.begin(), result.end());
        return result;
    }
};