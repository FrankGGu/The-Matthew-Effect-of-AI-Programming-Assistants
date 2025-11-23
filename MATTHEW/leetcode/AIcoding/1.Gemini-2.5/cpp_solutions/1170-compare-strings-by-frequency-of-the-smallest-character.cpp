#include <string>
#include <vector>
#include <algorithm>
#include <map>

class Solution {
public:
    int calculate_f(const std::string& s) {
        std::vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }
        for (int i = 0; i < 26; ++i) {
            if (freq[i] > 0) {
                return freq[i];
            }
        }
        return 0;
    }

    std::vector<int> numSmallerByFrequency(std::vector<std::string>& queries, std::vector<std::string>& words) {
        std::vector<int> word_frequencies;
        for (const std::string& word : words) {
            word_frequencies.push_back(calculate_f(word));
        }

        std::sort(word_frequencies.begin(), word_frequencies.end());

        std::vector<int> answer;
        for (const std::string& query : queries) {
            int query_f = calculate_f(query);

            auto it = std::upper_bound(word_frequencies.begin(), word_frequencies.end(), query_f);

            answer.push_back(std::distance(it, word_frequencies.end()));
        }

        return answer;
    }
};