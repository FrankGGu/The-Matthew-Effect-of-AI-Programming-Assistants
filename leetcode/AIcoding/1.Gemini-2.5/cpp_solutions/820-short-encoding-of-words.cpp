#include <string>
#include <vector>
#include <unordered_set>

class Solution {
public:
    int minimumLengthEncoding(std::vector<std::string>& words) {
        std::unordered_set<std::string> unique_words(words.begin(), words.end());

        for (const std::string& word : words) {
            for (int i = 1; i < word.length(); ++i) {
                std::string suffix = word.substr(i);
                if (unique_words.count(suffix)) {
                    unique_words.erase(suffix);
                }
            }
        }

        int total_length = 0;
        for (const std::string& word : unique_words) {
            total_length += word.length() + 1;
        }

        return total_length;
    }
};