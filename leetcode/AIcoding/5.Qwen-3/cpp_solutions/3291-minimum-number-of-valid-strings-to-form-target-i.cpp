#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minValidStrings(vector<string>& words, string target) {
        vector<int> dp(target.size() + 1, 0);
        for (int i = 1; i <= target.size(); ++i) {
            dp[i] = INT_MAX;
            for (const string& word : words) {
                if (i >= word.size() && target.substr(i - word.size(), word.size()) == word) {
                    dp[i] = min(dp[i], dp[i - word.size()] + 1);
                }
            }
        }
        return dp[target.size()];
    }
};