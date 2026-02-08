#include <string>
#include <vector>
#include <sstream>
#include <algorithm>

class Solution {
public:
    std::string rearrangeWords(std::string text) {
        if (text.empty()) {
            return "";
        }

        text[0] = std::tolower(text[0]);

        std::stringstream ss(text);
        std::string word;
        std::vector<std::string> words;
        while (ss >> word) {
            words.push_back(word);
        }

        std::stable_sort(words.begin(), words.end(), [](const std::string& a, const std::string& b) {
            return a.length() < b.length();
        });

        std::string result = "";
        if (!words.empty()) {
            words[0][0] = std::toupper(words[0][0]);
            result += words[0];
            for (size_t i = 1; i < words.size(); ++i) {
                result += " ";
                result += words[i];
            }
        }

        return result;
    }
};