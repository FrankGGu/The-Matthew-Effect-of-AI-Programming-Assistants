#include <vector>
#include <string>
#include <unordered_set>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countSubstrings(string s, int k) {
        unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u'};
        int n = s.size();
        int result = 0;

        for (int i = 0; i < n; ++i) {
            unordered_set<char> current_vowels;
            int consonant_count = 0;

            for (int j = i; j < n; ++j) {
                char c = s[j];
                if (vowels.count(c)) {
                    current_vowels.insert(c);
                } else {
                    consonant_count++;
                }

                if (current_vowels.size() == 5 && consonant_count == k) {
                    result++;
                }
            }
        }

        return result;
    }
};