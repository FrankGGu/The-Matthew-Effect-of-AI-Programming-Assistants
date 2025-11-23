#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    bool isAnagram(std::string s, std::string t) {
        if (s.length() != t.length()) {
            return false;
        }

        std::vector<int> charCounts(26, 0);

        for (char c : s) {
            charCounts[c - 'a']++;
        }

        for (char c : t) {
            charCounts[c - 'a']--;
            if (charCounts[c - 'a'] < 0) {
                return false;
            }
        }

        // After iterating through t, if all counts are zero, it's an anagram.
        // The check `charCounts[c - 'a'] < 0` already handles cases where t has
        // characters not in s or more of a character than s.
        // If we reach here, it means all characters in t were found in s
        // with sufficient counts. Since lengths are equal, all counts must be zero.
        return true;
    }
};