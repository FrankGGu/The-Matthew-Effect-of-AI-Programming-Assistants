#include <vector>
#include <string>
#include <cctype> // For std::tolower

class Solution {
public:
    std::vector<std::string> findWords(std::vector<std::string>& words) {
        std::vector<std::string> result;

        int charRow[26]; // Maps 'a' through 'z' to their keyboard row (1, 2, or 3)

        std::string row1_chars = "qwertyuiop";
        std::string row2_chars = "asdfghjkl";
        std::string row3_chars = "zxcvbnm";

        for (char c : row1_chars) {
            charRow[c - 'a'] = 1;
        }
        for (char c : row2_chars) {
            charRow[c - 'a'] = 2;
        }
        for (char c : row3_chars) {
            charRow[c - 'a'] = 3;
        }

        for (const std::string& word : words) {
            if (word.empty()) {
                continue; 
            }

            int currentRow = charRow[std::tolower(word[0]) - 'a'];
            bool allInSameRow = true;

            for (size_t i = 1; i < word.length(); ++i) {
                if (charRow[std::tolower(word[i]) - 'a'] != currentRow) {
                    allInSameRow = false;
                    break;
                }
            }

            if (allInSameRow) {
                result.push_back(word);
            }
        }

        return result;
    }
};