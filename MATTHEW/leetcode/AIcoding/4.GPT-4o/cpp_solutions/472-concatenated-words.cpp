class Solution {
public:
    bool canForm(const string& word, const unordered_set<string>& wordSet, vector<int>& dp) {
        if (dp[word.size()] != -1) return dp[word.size()];
        dp[word.size()] = 0;
        for (int i = 1; i <= word.size(); ++i) {
            if (wordSet.count(word.substr(0, i)) && (i < word.size() && canForm(word.substr(i), wordSet, dp))) {
                dp[word.size()] = 1;
                break;
            }
        }
        return dp[word.size()];
    }

    vector<string> findAllConcatenatedWordsInADict(vector<string>& words) {
        unordered_set<string> wordSet(words.begin(), words.end());
        vector<string> result;
        for (const string& word : words) {
            if (word.empty()) continue;
            vector<int> dp(word.size() + 1, -1);
            dp[0] = 1;
            if (canForm(word, wordSet, dp)) {
                result.push_back(word);
            }
        }
        return result;
    }
};