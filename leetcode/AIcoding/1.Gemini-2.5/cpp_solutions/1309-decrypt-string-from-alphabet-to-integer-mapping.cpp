#include <string>
#include <vector>

class Solution {
public:
    std::string freqAlphabets(std::string s) {
        std::string result = "";
        int n = s.length();
        for (int i = 0; i < n; ) {
            if (i + 2 < n && s[i + 2] == '#') {
                int num = (s[i] - '0') * 10 + (s[i + 1] - '0');
                result += (char)('a' + num - 1);
                i += 3;
            } else {
                int num = s[i] - '0';
                result += (char)('a' + num - 1);
                i++;
            }
        }
        return result;
    }
};