class Solution {
public:
    string longestWord(vector<string>& words) {
        sort(words.begin(), words.end());
        unordered_set<string> built;
        string res;
        for (string word : words) {
            if (word.size() == 1 || built.count(word.substr(0, word.size() - 1))) {
                if (word.size() > res.size()) {
                    res = word;
                }
                built.insert(word);
            }
        }
        return res;
    }
};