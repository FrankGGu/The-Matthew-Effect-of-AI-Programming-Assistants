#include <string>
#include <vector>
#include <cmath>

class Solution {
public:
    bool checkAlmostEquivalent(std::string word1, std::string word2) {
        std::vector<int> freq(26, 0);
        for (char c : word1) {
            freq[c - 'a']++;
        }
        for (char c : word2) {
            freq[c - 'a']--;
        }
        for (int count : freq) {
            if (std::abs(count) > 3) {
                return false;
            }
        }
        return true;
    }
};