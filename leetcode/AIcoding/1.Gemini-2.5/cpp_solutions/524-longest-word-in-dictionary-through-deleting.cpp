#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string findLongestWord(std::string s, std::vector<std::string>& dictionary) {
        std::string longest_word = "";

        for (const std::string& word : dictionary) {
            if (isSubsequence(s, word)) {
                if (word.length() > longest_word.length()) {
                    longest_word = word;
                } else if (word.length() == longest_word.length()) {
                    if (word < longest_word) {
                        longest_word = word;
                    }
                }
            }
        }

        return longest_word;
    }

private:
    bool isSubsequence(const std::string& s, const std::string& t) {
        int i = 0; // Pointer for s
        int j = 0; // Pointer for t

        while (i < s.length() && j < t.length()) {
            if (s[i] == t[j]) {
                j++;
            }
            i++;
        }
        return j == t.length();
    }
};