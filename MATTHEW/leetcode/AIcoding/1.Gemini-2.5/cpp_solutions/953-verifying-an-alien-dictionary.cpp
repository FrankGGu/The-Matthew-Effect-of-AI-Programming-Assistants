#include <vector>
#include <string>
#include <array>

class Solution {
public:
    bool isAlienSorted(std::vector<std::string>& words, std::string order) {
        std::array<int, 26> char_order;
        for (int i = 0; i < order.length(); ++i) {
            char_order[order[i] - 'a'] = i;
        }

        for (int i = 0; i < words.size() - 1; ++i) {
            const std::string& word1 = words[i];
            const std::string& word2 = words[i+1];

            bool found_diff = false;
            int len = std::min(word1.length(), word2.length());

            for (int j = 0; j < len; ++j) {
                if (char_order[word1[j] - 'a'] < char_order[word2[j] - 'a']) {
                    found_diff = true;
                    break;
                }
                if (char_order[word1[j] - 'a'] > char_order[word2[j] - 'a']) {
                    return false;
                }
            }

            if (!found_diff && word1.length() > word2.length()) {
                return false;
            }
        }

        return true;
    }
};