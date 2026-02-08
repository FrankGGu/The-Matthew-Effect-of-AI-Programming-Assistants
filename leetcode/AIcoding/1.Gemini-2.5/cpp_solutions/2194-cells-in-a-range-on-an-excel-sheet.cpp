#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::string> cellsInRange(std::string s) {
        char col1 = s[0];
        char row1 = s[1];
        char col2 = s[3];
        char row2 = s[4];

        std::vector<std::string> result;

        for (char c = col1; c <= col2; ++c) {
            for (char r = row1; r <= row2; ++r) {
                std::string cell = "";
                cell += c;
                cell += r;
                result.push_back(cell);
            }
        }

        return result;
    }
};