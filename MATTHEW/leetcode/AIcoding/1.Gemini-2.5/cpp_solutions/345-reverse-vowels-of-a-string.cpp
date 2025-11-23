#include <string>
#include <algorithm>
#include <cctype>

class Solution {
public:
    bool isVowel(char c) {
        c = std::tolower(c);
        return (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u');
    }

    std::string reverseVowels(std::string s) {
        int left = 0;
        int right = s.length() - 1;

        while (left < right) {
            while (left < right && !isVowel(s[left])) {
                left++;
            }
            while (left < right && !isVowel(s[right])) {
                right--;
            }

            if (left < right) {
                std::swap(s[left], s[right]);
                left++;
                right--;
            }
        }
        return s;
    }
};