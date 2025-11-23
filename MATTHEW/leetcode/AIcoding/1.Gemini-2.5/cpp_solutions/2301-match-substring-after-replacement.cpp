#include <string>
#include <vector>
#include <set>

class Solution {
public:
    bool matchReplacement(std::string s, std::string sub, std::vector<std::vector<char>>& mappings) {
        std::vector<std::vector<bool>> canReplace(26, std::vector<bool>(26, false));

        for (int i = 0; i < 26; ++i) {
            canReplace[i][i] = true; // A character can always be replaced by itself
        }

        for (const auto& mapping : mappings) {
            canReplace[mapping[0] - 'a'][mapping[1] - 'a'] = true;
        }

        int n = s.length();
        int m = sub.length();

        if (m > n) {
            return false;
        }

        for (int i = 0; i <= n - m; ++i) {
            bool currentSubMatch = true;
            for (int j = 0; j < m; ++j) {
                char sChar = s[i + j];
                char subChar = sub[j];

                if (!canReplace[subChar - 'a'][sChar - 'a']) {
                    currentSubMatch = false;
                    break;
                }
            }
            if (currentSubMatch) {
                return true;
            }
        }

        return false;
    }
};