#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>

using namespace std;

int longestStrChain(vector<string>& words) {
    unordered_set<string> wordSet(words.begin(), words.end());
    unordered_map<string, int> dp;
    int maxLength = 1;

    sort(words.begin(), words.end(), [](const string& a, const string& b) {
        return a.size() < b.size();
    });

    for (const string& word : words) {
        dp[word] = 1;
        for (int i = 0; i < word.size(); ++i) {
            string predecessor = word;
            predecessor.erase(i, 1);
            if (wordSet.count(predecessor)) {
                dp[word] = max(dp[word], dp[predecessor] + 1);
            }
        }
        maxLength = max(maxLength, dp[word]);
    }

    return maxLength;
}