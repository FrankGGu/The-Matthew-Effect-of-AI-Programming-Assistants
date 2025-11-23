#include <string>
#include <vector>
#include <algorithm>
#include <cctype>

class Solution {
public:
    int numberOfSpecialChars(std::string s) {
        std::vector<int> last_occurrence_lower(26, -1);
        std::vector<int> first_occurrence_upper(26, s.length());

        for (int i = 0; i < s.length(); ++i) {
            if (std::islower(s[i])) {
                last_occurrence_lower[s[i] - 'a'] = i;
            } else if (std::isupper(s[i])) {
                first_occurrence_upper[s[i] - 'A'] = std::min(first_occurrence_upper[s[i] - 'A'], i);
            }
        }

        int special_chars_count = 0;
        for (int i = 0; i < 26; ++i) {
            if (last_occurrence_lower[i] != -1 && 
                first_occurrence_upper[i] != s.length() && 
                last_occurrence_lower[i] < first_occurrence_upper[i]) {
                special_chars_count++;
            }
        }

        return special_chars_count;
    }
};