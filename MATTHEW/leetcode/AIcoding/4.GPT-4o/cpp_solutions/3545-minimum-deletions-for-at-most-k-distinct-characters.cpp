#include <unordered_map>
#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minDeletions(std::string s, int k) {
        std::unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        std::vector<int> counts;
        for (auto& p : freq) {
            counts.push_back(p.second);
        }

        std::sort(counts.rbegin(), counts.rend());

        int deletions = 0;
        int distinctCount = counts.size();

        for (int i = k; i < distinctCount; ++i) {
            deletions += counts[i];
        }

        return deletions;
    }
};