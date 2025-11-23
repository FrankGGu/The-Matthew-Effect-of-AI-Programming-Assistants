#include <string>
#include <vector>

class Solution {
public:
    std::string addSpaces(std::string s, std::vector<int>& spaces) {
        std::string res;
        res.reserve(s.length() + spaces.size());
        int space_ptr = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (space_ptr < spaces.size() && i == spaces[space_ptr]) {
                res.push_back(' ');
                space_ptr++;
            }
            res.push_back(s[i]);
        }
        return res;
    }
};