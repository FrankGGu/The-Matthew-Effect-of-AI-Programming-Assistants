#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> wordBreak(string s, vector<string>& wordDict) {
        unordered_set<string> wordSet(wordDict.begin(), wordDict.end());
        unordered_map<string, vector<string>> memo;
        return helper(s, wordSet, memo);
    }

private:
    vector<string> helper(string s, const unordered_set<string>& wordSet, unordered_map<string, vector<string>>& memo) {
        if (memo.find(s) != memo.end()) {
            return memo[s];
        }

        vector<string> result;

        for (int i = 1; i <= s.size(); ++i) {
            string word = s.substr(0, i);
            if (wordSet.find(word) != wordSet.end()) {
                if (i == s.size()) {
                    result.push_back(word);
                } else {
                    vector<string> nextResults = helper(s.substr(i), wordSet, memo);
                    for (string& next : nextResults) {
                        result.push_back(word + " " + next);
                    }
                }
            }
        }

        memo[s] = result;
        return result;
    }
};