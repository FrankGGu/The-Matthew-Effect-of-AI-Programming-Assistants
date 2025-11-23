#include <string>
#include <vector>
#include <algorithm> // Not strictly needed for this approach, but good to include if using sort

class Solution {
public:
    std::string customSortString(std::string order, std::string s) {
        std::vector<int> char_counts(26, 0);

        // Count character frequencies in s
        for (char c : s) {
            char_counts[c - 'a']++;
        }

        std::string result = "";
        result.reserve(s.length()); // Pre-allocate memory for efficiency

        // Append characters based on 'order'
        for (char c : order) {
            while (char_counts[c - 'a'] > 0) {
                result += c;
                char_counts[c - 'a']--;
            }
        }

        // Append remaining characters (those not in 'order')
        // These can be appended in any order, so alphabetical is fine.
        for (int i = 0; i < 26; ++i) {
            char c = 'a' + i;
            while (char_counts[i] > 0) {
                result += c;
                char_counts[i]--;
            }
        }

        return result;
    }
};