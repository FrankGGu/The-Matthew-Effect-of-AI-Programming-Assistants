#include <string>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int minimumOperationsToMakeKPeriodic(std::string word, int k) {
        int n = word.length();
        std::unordered_map<std::string, int> freq;

        for (int i = 0; i < n; i += k) {
            freq[word.substr(i, k)]++;
        }

        int max_freq = 0;
        for (const auto& pair : freq) {
            if (pair.second > max_freq) {
                max_freq = pair.second;
            }
        }

        int total_blocks = n / k;
        return total_blocks - max_freq;
    }
};