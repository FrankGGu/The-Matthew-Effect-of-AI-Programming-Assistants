#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    bool isAlienSorted(std::vector<std::string>& words, std::string order) {
        int char_to_int[26];
        for (int i = 0; i < order.length(); ++i) {
            char_to_int[order[i] - 'a'] = i;
        }

        for (int i = 0; i < words.size() - 1; ++i) {
            std::string& word1 = words[i];
            std::string& word2 = words[i+1];

            bool found_diff = false;
            int len1 = word1.length();
            int len2 = word2.length();
            int min_len = std::min(len1, len2);

            for (int j = 0; j < min_len; ++j) {
                int rank1 = char_to_int[word1[j] - 'a'];
                int rank2 = char_to_int[word2[j] - 'a'];

                if (rank1 < rank2) {
                    found_diff = true;
                    break;
                } else if (rank1 > rank2) {
                    return false;
                }
            }

            if (!found_diff) {
                if (len1 > len2) {
                    return false;
                }
            }
        }

        return true;
    }
};