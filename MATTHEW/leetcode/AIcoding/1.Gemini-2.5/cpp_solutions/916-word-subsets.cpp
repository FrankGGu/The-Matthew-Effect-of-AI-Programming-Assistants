#include <vector>
#include <string>
#include <algorithm>
#include <numeric>

class Solution {
public:
    std::vector<int> count_freq(const std::string& s) {
        std::vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }
        return freq;
    }

    std::vector<std::string> wordSubsets(std::vector<std::string>& words1, std::vector<std::string>& words2) {
        std::vector<int> max_freq_b(26, 0);

        for (const std::string& word2 : words2) {
            std::vector<int> current_freq_b = count_freq(word2);
            for (int i = 0; i < 26; ++i) {
                max_freq_b[i] = std::max(max_freq_b[i], current_freq_b[i]);
            }
        }

        std::vector<std::string> result;
        for (const std::string& word1 : words1) {
            std::vector<int> freq_a = count_freq(word1);
            bool is_universal = true;
            for (int i = 0; i < 26; ++i) {
                if (freq_a[i] < max_freq_b[i]) {
                    is_universal = false;
                    break;
                }
            }
            if (is_universal) {
                result.push_back(word1);
            }
        }

        return result;
    }
};