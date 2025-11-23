#include <string>
#include <vector>
#include <sstream>
#include <cctype>

class Solution {
public:
    int countValidWords(std::string sentence) {
        std::stringstream ss(sentence);
        std::string token;
        int count = 0;
        while (ss >> token) {
            if (isValid(token)) {
                count++;
            }
        }
        return count;
    }

private:
    bool isValid(const std::string& token) {
        int n = token.length();
        if (n == 0) {
            return false;
        }

        int hyphenCount = 0;
        for (int i = 0; i < n; ++i) {
            char c = token[i];

            if (std::isdigit(c)) {
                return false;
            }

            if (c == '-') {
                hyphenCount++;
                if (hyphenCount > 1) {
                    return false;
                }
                if (i == 0 || i == n - 1) {
                    return false;
                }
                if (!std::islower(token[i - 1]) || !std::islower(token[i + 1])) {
                    return false;
                }
            }

            if (c == '!' || c == '.' || c == ',') {
                if (i != n - 1) {
                    return false;
                }
            }
        }
        return true;
    }
};