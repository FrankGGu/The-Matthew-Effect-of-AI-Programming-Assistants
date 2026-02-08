#include <string>
#include <vector>

class Solution {
public:
    bool isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    int countBeautifulSubstrings(std::string s, int k) {
        int n = s.length();
        int beautifulSubstringsCount = 0;

        for (int i = 0; i < n; ++i) {
            int vowelCount = 0;
            int consonantCount = 0;
            for (int j = i; j < n; ++j) {
                if (isVowel(s[j])) {
                    vowelCount++;
                } else {
                    consonantCount++;
                }

                if (vowelCount == consonantCount) {
                    if ((1LL * vowelCount * consonantCount) % k == 0) {
                        beautifulSubstringsCount++;
                    }
                }
            }
        }
        return beautifulSubstringsCount;
    }
};