#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<string> wordBreak(string s, vector<string>& wordDict) {
        unordered_set<string> dict(wordDict.begin(), wordDict.end());
        vector<string> res;
        string current;
        helper(s, dict, 0, current, res);
        return res;
    }

private:
    void helper(string s, unordered_set<string>& dict, int start, string current, vector<string>& res) {
        if (start == s.size()) {
            res.push_back(current.substr(0, current.size() - 1));
            return;
        }

        for (int i = start; i < s.size(); ++i) {
            string word = s.substr(start, i - start + 1);
            if (dict.count(word)) {
                helper(s, dict, i + 1, current + word + " ", res);
            }
        }
    }
};