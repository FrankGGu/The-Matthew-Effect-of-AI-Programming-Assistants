#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int minDeletions(std::string s, int k) {
        std::unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        if (freq.size() <= k) {
            return 0;
        }

        std::vector<int> counts;
        for (auto const& pair : freq) {
            counts.push_back(pair.second);
        }

        std::sort(counts.begin(), counts.end());

        int deletions = 0;
        int num_chars_to_remove = counts.size() - k;
        for (int i = 0; i < num_chars_to_remove; ++i) {
            deletions += counts[i];
        }

        return deletions;
    }
};