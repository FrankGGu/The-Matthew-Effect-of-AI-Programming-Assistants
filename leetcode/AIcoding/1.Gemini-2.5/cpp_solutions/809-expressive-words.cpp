#include <string>
#include <vector>

class Solution {
public:
    int expressiveWords(std::string s, std::vector<std::string>& words) {
        int count = 0;
        for (const std::string& word : words) {
            if (isStretchy(s, word)) {
                count++;
            }
        }
        return count;
    }

private:
    bool isStretchy(const std::string& s, const std::string& word) {
        int i = 0; // Pointer for string s
        int j = 0; // Pointer for string word

        while (i < s.length() && j < word.length()) {
            if (s[i] != word[j]) {
                return false;
            }

            char currentChar = s[i];
            int s_count = 0;
            while (i < s.length() && s[i] == currentChar) {
                s_count++;
                i++;
            }

            int w_count = 0;
            while (j < word.length() && word[j] == currentChar) {
                w_count++;
                j++;
            }

            if (s_count < w_count) {
                return false;
            }

            if (s_count > w_count && s_count < 3) {
                return false;
            }
        }

        return i == s.length() && j == word.length();
    }
};