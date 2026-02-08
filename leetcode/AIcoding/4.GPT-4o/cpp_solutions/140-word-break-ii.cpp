class Solution {
public:
    vector<string> wordBreak(string s, vector<string>& wordDict) {
        unordered_set<string> dict(wordDict.begin(), wordDict.end());
        unordered_map<string, vector<string>> memo;
        return backtrack(s, dict, memo);
    }

    vector<string> backtrack(string s, unordered_set<string>& dict, unordered_map<string, vector<string>>& memo) {
        if (memo.count(s)) return memo[s];
        if (s.empty()) return {""};

        vector<string> result;
        for (int i = 1; i <= s.size(); ++i) {
            string word = s.substr(0, i);
            if (dict.count(word)) {
                vector<string> sublist = backtrack(s.substr(i), dict, memo);
                for (string sub : sublist) {
                    result.push_back(word + (sub.empty() ? "" : " ") + sub);
                }
            }
        }
        return memo[s] = result;
    }
};