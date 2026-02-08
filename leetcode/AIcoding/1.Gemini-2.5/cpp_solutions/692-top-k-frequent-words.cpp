#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::vector<std::string> topKFrequent(std::vector<std::string>& words, int k) {
        std::unordered_map<std::string, int> freq_map;
        for (const std::string& word : words) {
            freq_map[word]++;
        }

        std::vector<std::pair<std::string, int>> word_freq_pairs;
        word_freq_pairs.reserve(freq_map.size());
        for (const auto& entry : freq_map) {
            word_freq_pairs.push_back(entry);
        }

        std::sort(word_freq_pairs.begin(), word_freq_pairs.end(), [](const std::pair<std::string, int>& a, const std::pair<std::string, int>& b) {
            if (a.second != b.second) {
                return a.second > b.second;
            }
            return a.first < b.first;
        });

        std::vector<std::string> result;
        result.reserve(k);
        for (int i = 0; i < k; ++i) {
            result.push_back(word_freq_pairs[i].first);
        }

        return result;
    }
};