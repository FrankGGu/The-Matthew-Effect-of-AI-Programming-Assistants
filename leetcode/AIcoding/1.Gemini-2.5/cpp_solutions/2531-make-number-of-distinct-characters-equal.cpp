#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    bool equalDistinctCharacters(std::string word1, std::string word2) {
        std::vector<int> freq1(26, 0);
        for (char c : word1) {
            freq1[c - 'a']++;
        }

        std::vector<int> freq2(26, 0);
        for (char c : word2) {
            freq2[c - 'a']++;
        }

        for (int i = 0; i < 26; ++i) { // Character from word1
            for (int j = 0; j < 26; ++j) { // Character from word2
                // Simulate swap
                std::vector<int> temp_freq1 = freq1;
                std::vector<int> temp_freq2 = freq2;

                // Decrease count of char_i in word1, increase count of char_j in word1
                temp_freq1[i]--;
                temp_freq1[j]++;

                // Decrease count of char_j in word2, increase count of char_i in word2
                temp_freq2[j]--;
                temp_freq2[i]++;

                // Calculate distinct characters for temp_freq1
                int distinct1 = 0;
                for (int k = 0; k < 26; ++k) {
                    if (temp_freq1[k] > 0) {
                        distinct1++;
                    }
                }

                // Calculate distinct characters for temp_freq2
                int distinct2 = 0;
                for (int k = 0; k < 26; ++k) {
                    if (temp_freq2[k] > 0) {
                        distinct2++;
                    }
                }

                if (distinct1 == distinct2) {
                    return true;
                }
            }
        }

        return false;
    }
};