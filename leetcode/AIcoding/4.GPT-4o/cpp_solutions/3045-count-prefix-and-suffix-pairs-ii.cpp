#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPrefixSuffixPairs(vector<string>& words) {
        unordered_map<string, int> prefixCount;
        int count = 0;

        for (const string& word : words) {
            string reversedWord = string(word.rbegin(), word.rend());
            prefixCount[reversedWord]++;
        }

        for (const string& word : words) {
            for (int i = 1; i < word.size(); ++i) {
                string prefix = word.substr(0, i);
                if (prefixCount.count(prefix)) {
                    count += prefixCount[prefix];
                }
            }
        }

        return count;
    }
};