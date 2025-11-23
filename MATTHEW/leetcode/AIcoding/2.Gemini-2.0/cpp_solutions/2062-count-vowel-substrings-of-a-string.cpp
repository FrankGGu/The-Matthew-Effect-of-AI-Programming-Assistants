#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countVowelSubstrings(string word) {
        int n = word.size();
        int count = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                unordered_set<char> vowels;
                bool valid = true;

                for (int k = i; k <= j; ++k) {
                    if (word[k] == 'a' || word[k] == 'e' || word[k] == 'i' || word[k] == 'o' || word[k] == 'u') {
                        vowels.insert(word[k]);
                    } else {
                        valid = false;
                        break;
                    }
                }

                if (valid && vowels.size() == 5) {
                    count++;
                }
            }
        }

        return count;
    }
};