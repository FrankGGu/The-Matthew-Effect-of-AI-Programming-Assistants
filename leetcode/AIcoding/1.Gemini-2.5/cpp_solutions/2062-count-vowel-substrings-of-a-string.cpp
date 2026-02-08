#include <string>
#include <set>
#include <vector>

class Solution {
public:
    bool isVowelChar(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    int countVowelSubstrings(std::string word) {
        int n = word.length();
        int count = 0;

        for (int i = 0; i < n; ++i) {
            std::set<char> currentVowels;
            for (int j = i; j < n; ++j) {
                char c = word[j];
                if (!isVowelChar(c)) {
                    break;
                }
                currentVowels.insert(c);
                if (currentVowels.size() == 5) {
                    count++;
                }
            }
        }
        return count;
    }
};