#include <string>
#include <sstream>

class Solution {
public:
    int isPrefixOfWord(std::string sentence, std::string searchWord) {
        std::stringstream ss(sentence);
        std::string word;
        int wordCount = 0;
        int searchWordLen = searchWord.length();

        while (ss >> word) {
            wordCount++;
            if (word.length() >= searchWordLen) {
                if (word.compare(0, searchWordLen, searchWord) == 0) {
                    return wordCount;
                }
            }
        }
        return -1;
    }
};