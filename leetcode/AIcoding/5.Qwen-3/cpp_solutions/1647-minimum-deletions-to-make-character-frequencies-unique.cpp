#include <iostream>
#include <vector>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int minDeletions(std::string s) {
        std::vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        std::unordered_set<int> usedFreq;
        int deletions = 0;

        for (int i = 0; i < 26; ++i) {
            while (freq[i] > 0 && usedFreq.find(freq[i]) != usedFreq.end()) {
                freq[i]--;
                deletions++;
            }
            if (freq[i] > 0) {
                usedFreq.insert(freq[i]);
            }
        }

        return deletions;
    }
};