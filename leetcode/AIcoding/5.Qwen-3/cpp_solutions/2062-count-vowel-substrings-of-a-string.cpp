#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countVowelSubstrings(string s) {
        int count = 0;
        unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u'};
        int n = s.length();

        for (int i = 0; i < n; ++i) {
            if (vowels.find(s[i]) == vowels.end()) continue;
            unordered_set<char> current;
            current.insert(s[i]);
            for (int j = i + 1; j <= n; ++j) {
                if (vowels.find(s[j]) == vowels.end()) break;
                current.insert(s[j]);
                if (current.size() == 5) ++count;
            }
        }

        return count;
    }
};