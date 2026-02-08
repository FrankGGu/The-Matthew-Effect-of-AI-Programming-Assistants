#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string sortString(std::string s) {
        std::vector<int> counts(26, 0);
        for (char c : s) {
            counts[c - 'a']++;
        }

        std::string result = "";
        int total_chars = s.length();

        while (result.length() < total_chars) {
            // Ascending pass
            for (int i = 0; i < 26; ++i) {
                if (counts[i] > 0) {
                    result += (char)('a' + i);
                    counts[i]--;
                }
            }

            // Descending pass
            for (int i = 25; i >= 0; --i) {
                if (counts[i] > 0) {
                    result += (char)('a' + i);
                    counts[i]--;
                }
            }
        }

        return result;
    }
};