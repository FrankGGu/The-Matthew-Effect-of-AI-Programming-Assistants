#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    bool canConstruct(std::string ransomNote, std::string magazine) {
        std::vector<int> char_counts(26, 0);

        for (char c : magazine) {
            char_counts[c - 'a']++;
        }

        for (char c : ransomNote) {
            char_counts[c - 'a']--;
            if (char_counts[c - 'a'] < 0) {
                return false;
            }
        }

        return true;
    }
};