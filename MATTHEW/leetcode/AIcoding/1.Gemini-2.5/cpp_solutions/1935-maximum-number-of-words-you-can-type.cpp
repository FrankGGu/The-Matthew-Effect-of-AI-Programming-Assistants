#include <string>
#include <vector>
#include <sstream>

class Solution {
public:
    int canBeTypedWords(std::string text, std::string brokenLetters) {
        std::vector<bool> isBroken(26, false);
        for (char c : brokenLetters) {
            isBroken[c - 'a'] = true;
        }

        int typedWordsCount = 0;
        std::istringstream iss(text);
        std::string word;

        while (iss >> word) {
            bool canTypeWord = true;
            for (char c : word) {
                if (isBroken[c - 'a']) {
                    canTypeWord = false;
                    break;
                }
            }
            if (canTypeWord) {
                typedWordsCount++;
            }
        }

        return typedWordsCount;
    }
};