#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    std::string reorderSpaces(std::string text) {
        int totalSpaces = 0;
        std::vector<std::string> words;
        std::string currentWord;

        for (char c : text) {
            if (c == ' ') {
                totalSpaces++;
                if (!currentWord.empty()) {
                    words.push_back(currentWord);
                    currentWord.clear();
                }
            } else {
                currentWord += c;
            }
        }
        if (!currentWord.empty()) {
            words.push_back(currentWord);
        }

        int numWords = words.size();
        int spacesPerGap;
        int trailingSpaces;

        if (numWords == 1) {
            spacesPerGap = 0;
            trailingSpaces = totalSpaces;
        } else {
            spacesPerGap = totalSpaces / (numWords - 1);
            trailingSpaces = totalSpaces % (numWords - 1);
        }

        std::string result = "";
        std::string gap = std::string(spacesPerGap, ' ');

        for (int i = 0; i < numWords; ++i) {
            result += words[i];
            if (i < numWords - 1) {
                result += gap;
            }
        }
        result += std::string(trailingSpaces, ' ');

        return result;
    }
};