#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    std::vector<int> numSmallerByFrequency(std::vector<std::string>& queries, std::vector<std::string>& words) {
        auto f = [](const std::string& s) {
            return std::count(s.begin(), s.end(), *std::min_element(s.begin(), s.end()));
        };

        std::vector<int> wordFreq;
        for (const auto& word : words) {
            wordFreq.push_back(f(word));
        }

        std::sort(wordFreq.begin(), wordFreq.end());

        std::vector<int> result;
        for (const auto& query : queries) {
            int queryFreq = f(query);
            result.push_back(wordFreq.end() - std::upper_bound(wordFreq.begin(), wordFreq.end(), queryFreq));
        }

        return result;
    }
};