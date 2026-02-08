#include <string>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int firstUniqChar(std::string s) {
        std::vector<int> char_counts(26, 0);

        for (char c : s) {
            char_counts[c - 'a']++;
        }

        for (int i = 0; i < s.length(); ++i) {
            if (char_counts[s[i] - 'a'] == 1) {
                return i;
            }
        }

        return -1;
    }
};