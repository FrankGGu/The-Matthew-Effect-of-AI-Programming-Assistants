#include <vector>
#include <string>
#include <sstream>
#include <unordered_map>

class Solution {
public:
    std::vector<std::string> uncommonFromSentences(std::string s1, std::string s2) {
        std::unordered_map<std::string, int> word_counts;
        std::stringstream ss1(s1);
        std::string word;

        while (ss1 >> word) {
            word_counts[word]++;
        }

        std::stringstream ss2(s2);
        while (ss2 >> word) {
            word_counts[word]++;
        }

        std::vector<std::string> uncommon_words;
        for (const auto& pair : word_counts) {
            if (pair.second == 1) {
                uncommon_words.push_back(pair.first);
            }
        }

        return uncommon_words;
    }
};