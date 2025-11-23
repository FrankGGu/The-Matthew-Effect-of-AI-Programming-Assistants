class Solution {
public:
    char repeatedCharacter(std::string s) {
        bool seen[26] = {false};
        for (char c : s) {
            int index = c - 'a';
            if (seen[index]) {
                return c;
            }
            seen[index] = true;
        }
        return ' '; // Should not be reached based on problem constraints
    }
};