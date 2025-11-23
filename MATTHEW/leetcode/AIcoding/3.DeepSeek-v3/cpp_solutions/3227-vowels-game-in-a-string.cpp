#include <unordered_set>

class Solution {
public:
    int countVowels(std::string s) {
        std::unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u'};
        int total = 0;
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            if (vowels.count(s[i])) {
                total += (i + 1) * (n - i);
            }
        }
        return total;
    }
};