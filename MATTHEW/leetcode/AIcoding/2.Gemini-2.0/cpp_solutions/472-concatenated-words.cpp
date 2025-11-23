#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool canForm(string word, unordered_set<string>& wordSet) {
        if (wordSet.empty()) return false;
        vector<bool> dp(word.size() + 1, false);
        dp[0] = true;

        for (int i = 1; i <= word.size(); ++i) {
            for (int j = 0; j < i; ++j) {
                if (dp[j] && wordSet.count(word.substr(j, i - j))) {
                    dp[i] = true;
                    break;
                }
            }
        }

        return dp[word.size()];
    }

    vector<string> findAllConcatenatedWordsInADict(vector<string>& words) {
        vector<string> result;
        unordered_set<string> wordSet;

        for (string word : words) {
            wordSet.insert(word);
        }

        for (string word : words) {
            wordSet.erase(word);
            if (canForm(word, wordSet)) {
                result.push_back(word);
            }
            wordSet.insert(word);
        }

        return result;
    }
};