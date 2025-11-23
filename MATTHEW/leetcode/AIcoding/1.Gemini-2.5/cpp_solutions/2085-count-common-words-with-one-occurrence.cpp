#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    int countWords(std::vector<std::string>& words1, std::vector<std::string>& words2) {
        std::unordered_map<std::string, int> freq1;
        std::unordered_map<std::string, int> freq2;

        for (const std::string& word : words1) {
            freq1[word]++;
        }

        for (const std::string& word : words2) {
            freq2[word]++;
        }

        int count = 0;
        for (const auto& pair : freq1) {
            if (pair.second == 1) {
                auto it = freq2.find(pair.first);
                if (it != freq2.end() && it->second == 1) {
                    count++;
                }
            }
        }

        return count;
    }
};