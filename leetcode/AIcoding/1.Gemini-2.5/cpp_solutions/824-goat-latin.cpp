#include <string>
#include <vector>
#include <sstream>
#include <set>

class Solution {
public:
    std::string toGoatLatin(std::string sentence) {
        std::stringstream ss(sentence);
        std::string word;
        std::string result = "";
        int wordIndex = 1;

        std::set<char> vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'};

        while (ss >> word) {
            if (wordIndex > 1) {
                result += " ";
            }

            char firstChar = word[0];
            if (vowels.count(firstChar)) {
                result += word;
            } else {
                result += word.substr(1);
                result += firstChar;
            }
            result += "ma";

            for (int i = 0; i < wordIndex; ++i) {
                result += 'a';
            }
            wordIndex++;
        }

        return result;
    }
};