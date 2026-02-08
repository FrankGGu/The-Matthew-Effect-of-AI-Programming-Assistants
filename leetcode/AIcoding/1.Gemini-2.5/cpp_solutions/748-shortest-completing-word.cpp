#include <string>
#include <vector>
#include <cctype>
#include <limits> // For numeric_limits

class Solution {
public:
    std::string shortestCompletingWord(std::string licensePlate, std::vector<std::string>& words) {
        std::vector<int> lp_freq(26, 0);
        for (char c : licensePlate) {
            if (std::isalpha(c)) {
                lp_freq[std::tolower(c) - 'a']++;
            }
        }

        std::string shortest_word = "";
        int min_len = std::numeric_limits<int>::max();

        for (const std::string& word : words) {
            std::vector<int> word_freq(26, 0);
            for (char c : word) {
                word_freq[std::tolower(c) - 'a']++;
            }

            bool completes = true;
            for (int i = 0; i < 26; ++i) {
                if (lp_freq[i] > word_freq[i]) {
                    completes = false;
                    break;
                }
            }

            if (completes) {
                if (word.length() < min_len) {
                    min_len = word.length();
                    shortest_word = word;
                }
            }
        }

        return shortest_word;
    }
};