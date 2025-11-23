#include <vector>
#include <string>
#include <algorithm>
#include <unordered_set>

class Solution {
public:
    std::string longestWord(std::vector<std::string>& words) {
        std::sort(words.begin(), words.end());

        std::unordered_set<std::string> valid_words_set;
        std::string longest_word = "";

        for (const std::string& word : words) {
            if (word.length() == 1 || valid_words_set.count(word.substr(0, word.length() - 1))) {
                valid_words_set.insert(word);

                if (word.length() > longest_word.length()) {
                    longest_word = word;
                }
            }
        }

        return longest_word;
    }
};