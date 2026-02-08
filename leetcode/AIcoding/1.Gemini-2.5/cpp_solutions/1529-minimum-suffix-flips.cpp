#include <string>

class Solution {
public:
    int minFlips(std::string target) {
        int flips = 0;
        char current_effective_char = '0';

        for (char c : target) {
            if (c != current_effective_char) {
                flips++;
                current_effective_char = (current_effective_char == '0' ? '1' : '0');
            }
        }
        return flips;
    }
};