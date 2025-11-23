class Solution {
public:
    int minimumLengthEncoding(vector<string>& words) {
        unordered_set<string> s(words.begin(), words.end());
        for (const string& word : words) {
            for (int k = 1; k < word.size(); ++k) {
                s.erase(word.substr(k));
            }
        }
        int res = 0;
        for (const string& word : s) {
            res += word.size() + 1;
        }
        return res;
    }
};