#include <string>
#include <vector>
#include <algorithm>
#include <sstream>

class Solution {
public:
    std::string reverseWords(std::string s) {
        std::stringstream ss(s);
        std::string word;
        std::vector<std::string> words;

        while (ss >> word) {
            words.push_back(word);
        }

        std::reverse(words.begin(), words.end());

        std::string result = "";
        if (!words.empty()) {
            result += words[0];
            for (size_t i = 1; i < words.size(); ++i) {
                result += " " + words[i];
            }
        }

        return result;
    }
};