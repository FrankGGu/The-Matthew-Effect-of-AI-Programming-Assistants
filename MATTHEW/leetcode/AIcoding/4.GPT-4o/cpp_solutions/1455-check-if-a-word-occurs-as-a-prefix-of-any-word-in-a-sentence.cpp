#include <string>
#include <sstream>
#include <vector>

class Solution {
public:
    bool isPrefixOfWord(std::string sentence, std::string searchWord) {
        std::istringstream stream(sentence);
        std::string word;
        int index = 1;

        while (stream >> word) {
            if (word.substr(0, searchWord.size()) == searchWord) {
                return index;
            }
            index++;
        }

        return -1;
    }
};