#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    bool isValidWord(string word, vector<string>& dictionary) {
        vector<bool> dp(word.size() + 1, false);
        dp[0] = true;

        for (int i = 1; i <= word.size(); ++i) {
            for (int j = 0; j < i; ++j) {
                if (dp[j]) {
                    string sub = word.substr(j, i - j);
                    for (string& dictWord : dictionary) {
                        if (sub == dictWord) {
                            dp[i] = true;
                            break;
                        }
                    }
                }
                if (dp[i]) break;
            }
        }

        return dp[word.size()];
    }
};