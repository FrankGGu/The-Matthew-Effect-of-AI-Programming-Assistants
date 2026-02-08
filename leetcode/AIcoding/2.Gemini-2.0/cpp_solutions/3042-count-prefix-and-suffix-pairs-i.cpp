#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int countPrefixSuffixPairs(vector<string>& words) {
        int count = 0;
        int n = words.size();
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                string word1 = words[i];
                string word2 = words[j];
                if (word2.size() >= word1.size()) {
                    if (word2.substr(0, word1.size()) == word1 &&
                        word2.substr(word2.size() - word1.size()) == word1) {
                        count++;
                    }
                }
            }
        }
        return count;
    }
};