#include <vector>
#include <string>

class Solution {
public:
    std::vector<std::vector<int>> largeGroupPositions(std::string s) {
        std::vector<std::vector<int>> result;
        if (s.length() < 3) {
            return result;
        }

        int i = 0; // Start of the current group
        for (int j = 0; j < s.length(); ++j) {
            // Check if j is the last character or if the current character is different from the next
            if (j == s.length() - 1 || s[j] != s[j+1]) {
                // End of a group
                if (j - i + 1 >= 3) {
                    result.push_back({i, j});
                }
                // Start a new group from the next character
                i = j + 1;
            }
        }
        return result;
    }
};