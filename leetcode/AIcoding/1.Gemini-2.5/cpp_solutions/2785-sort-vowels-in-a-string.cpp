#include <string>
#include <vector>
#include <algorithm>
#include <cctype>

class Solution {
public:
    bool isVowel(char c) {
        c = std::tolower(c);
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    std::string sortVowels(std::string s) {
        std::vector<char> vowels;
        for (char c : s) {
            if (isVowel(c)) {
                vowels.push_back(c);
            }
        }

        std::sort(vowels.begin(), vowels.end());

        int vowel_idx = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (isVowel(s[i])) {
                s[i] = vowels[vowel_idx++];
            }
        }

        return s;
    }
};