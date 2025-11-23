#include <string>
#include <unordered_set>

class Solution {
public:
    bool halvesAreAlike(std::string s) {
        int n = s.length();
        int mid = n / 2;

        std::unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'};

        int countA = 0;
        for (int i = 0; i < mid; ++i) {
            if (vowels.count(s[i])) {
                countA++;
            }
        }

        int countB = 0;
        for (int i = mid; i < n; ++i) {
            if (vowels.count(s[i])) {
                countB++;
            }
        }

        return countA == countB;
    }
};