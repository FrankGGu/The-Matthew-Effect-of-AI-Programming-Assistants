#include <string>
#include <sstream>
#include <algorithm>

class Solution {
public:
    std::string reverseWords(std::string s) {
        std::stringstream ss(s);
        std::string word, result;
        while (ss >> word) {
            result = word + (result.empty() ? "" : " ") + result;
        }
        return result;
    }
};