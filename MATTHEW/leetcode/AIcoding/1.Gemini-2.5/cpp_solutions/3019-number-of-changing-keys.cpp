#include <string>
#include <cctype>

class Solution {
public:
    int countKeyChanges(std::string s) {
        int changes = 0;
        if (s.length() <= 1) {
            return 0;
        }
        for (int i = 1; i < s.length(); ++i) {
            if (std::tolower(s[i]) != std::tolower(s[i - 1])) {
                changes++;
            }
        }
        return changes;
    }
};