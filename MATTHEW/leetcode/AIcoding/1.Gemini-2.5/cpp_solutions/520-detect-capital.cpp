#include <string>
#include <cctype>

class Solution {
public:
    bool detectCapitalUse(std::string word) {
        int capital_count = 0;
        for (char c : word) {
            if (std::isupper(c)) {
                capital_count++;
            }
        }

        if (capital_count == 0) {
            return true;
        }
        if (capital_count == word.length()) {
            return true;
        }
        if (capital_count == 1 && std::isupper(word[0])) {
            return true;
        }

        return false;
    }
};