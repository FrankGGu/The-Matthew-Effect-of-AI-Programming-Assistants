#include <string>
#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minDeletions(std::string s) {
        std::vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        std::vector<bool> used_frequencies(s.length() + 1, false);
        int deletions = 0;

        for (int current_freq : freq) {
            while (current_freq > 0 && used_frequencies[current_freq]) {
                current_freq--;
                deletions++;
            }
            if (current_freq > 0) {
                used_frequencies[current_freq] = true;
            }
        }

        return deletions;
    }
};