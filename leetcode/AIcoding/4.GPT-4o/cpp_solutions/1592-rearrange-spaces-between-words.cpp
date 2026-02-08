#include <string>
#include <vector>
#include <sstream>

class Solution {
public:
    std::string rearrangeSpaces(std::string text) {
        std::vector<std::string> words;
        std::string word;
        int spaceCount = 0;

        std::istringstream stream(text);
        while (stream >> word) {
            words.push_back(word);
        }

        spaceCount = std::count(text.begin(), text.end(), ' ');
        int n = words.size();
        if (n == 1) {
            return words[0] + std::string(spaceCount, ' ');
        }

        int spacesBetween = spaceCount / (n - 1);
        int extraSpaces = spaceCount % (n - 1);
        std::string result;

        for (int i = 0; i < n; ++i) {
            result += words[i];
            if (i < n - 1) {
                result += std::string(spacesBetween, ' ');
            }
        }
        result += std::string(extraSpaces, ' ');

        return result;
    }
};