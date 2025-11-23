#include <string>
#include <algorithm>
#include <set>

class Solution {
public:
    bool isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    int maxVowels(std::string s, int k) {
        int n = s.length();
        int currentVowels = 0;

        for (int i = 0; i < k; ++i) {
            if (isVowel(s[i])) {
                currentVowels++;
            }
        }

        int maxVowelsCount = currentVowels;

        for (int i = k; i < n; ++i) {
            if (isVowel(s[i - k])) {
                currentVowels--;
            }
            if (isVowel(s[i])) {
                currentVowels++;
            }
            maxVowelsCount = std::max(maxVowelsCount, currentVowels);
        }

        return maxVowelsCount;
    }
};