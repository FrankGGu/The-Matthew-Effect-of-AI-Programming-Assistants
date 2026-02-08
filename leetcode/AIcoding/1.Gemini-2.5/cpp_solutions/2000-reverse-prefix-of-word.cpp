#include <string>
#include <algorithm>

class Solution {
public:
    std::string reversePrefix(std::string word, char ch) {
        size_t pos = word.find(ch);
        if (pos != std::string::npos) {
            std::reverse(word.begin(), word.begin() + pos + 1);
        }
        return word;
    }
};