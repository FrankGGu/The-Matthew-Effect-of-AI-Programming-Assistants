class Solution {
public:
    vector<string> findAllConcatenatedWordsInADict(vector<string>& words) {
        unordered_set<string> wordSet(words.begin(), words.end());
        vector<string> result;
        for (const string& word : words) {
            if (word.empty()) continue;
            wordSet.erase(word);
            if (canForm(word, wordSet)) {
                result.push_back(word);
            }
            wordSet.insert(word);
        }
        return result;
    }

private:
    bool canForm(const string& word, const unordered_set<string>& wordSet) {
        int n = word.size();
        vector<bool> dp(n + 1, false);
        dp[0] = true;
        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (dp[j] && wordSet.count(word.substr(j, i - j))) {
                    dp[i] = true;
                    break;
                }
            }
        }
        return dp[n];
    }
};