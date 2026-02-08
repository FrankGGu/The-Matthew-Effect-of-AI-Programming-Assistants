class Solution {
public:
    vector<string> wordBreak(string s, vector<string>& wordDict) {
        unordered_set<string> dict(wordDict.begin(), wordDict.end());
        unordered_map<int, vector<string>> memo;
        return dfs(s, dict, 0, memo);
    }

private:
    vector<string> dfs(const string& s, const unordered_set<string>& dict, int start, unordered_map<int, vector<string>>& memo) {
        if (memo.count(start)) {
            return memo[start];
        }
        vector<string> res;
        if (start == s.size()) {
            res.push_back("");
            return res;
        }
        for (int end = start + 1; end <= s.size(); ++end) {
            string word = s.substr(start, end - start);
            if (dict.count(word)) {
                vector<string> sublist = dfs(s, dict, end, memo);
                for (string sub : sublist) {
                    res.push_back(word + (sub.empty() ? "" : " ") + sub);
                }
            }
        }
        memo[start] = res;
        return res;
    }
};