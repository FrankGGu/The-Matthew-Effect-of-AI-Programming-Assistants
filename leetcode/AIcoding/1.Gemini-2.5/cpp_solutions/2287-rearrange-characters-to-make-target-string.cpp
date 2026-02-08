#include <string>
#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int rearrangeCharacters(std::string s, std::string target) {
        std::vector<int> s_counts(26, 0);
        for (char c : s) {
            s_counts[c - 'a']++;
        }

        std::vector<int> target_counts(26, 0);
        for (char c : target) {
            target_counts[c - 'a']++;
        }

        int max_copies = std::numeric_limits<int>::max();

        for (int i = 0; i < 26; ++i) {
            if (target_counts[i] > 0) {
                // This character is required by the target string
                // Calculate how many times we can form this character
                // given its frequency in s and target
                int current_char_copies = s_counts[i] / target_counts[i];
                max_copies = std::min(max_copies, current_char_copies);
            }
        }

        return max_copies;
    }
};