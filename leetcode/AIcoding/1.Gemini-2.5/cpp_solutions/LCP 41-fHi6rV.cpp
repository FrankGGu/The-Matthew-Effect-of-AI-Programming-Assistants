#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::string> generatePossibleNextMoves(std::string s) {
        std::vector<std::string> result;
        if (s.length() < 2) {
            return result;
        }

        for (int i = 0; i <= (int)s.length() - 2; ++i) {
            if (s[i] == '+' && s[i+1] == '+') {
                std::string temp = s;
                temp[i] = '-';
                temp[i+1] = '-';
                result.push_back(temp);
            }
        }
        return result;
    }
};