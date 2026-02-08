class Solution {
public:
    int minimumLengthEncoding(vector<string>& words) {
        unordered_set<string> wordSet(words.begin(), words.end());
        for (const string& word : words) {
            for (int i = 1; i < word.size(); ++i) {
                wordSet.erase(word.substr(i));
            }
        }
        int length = 0;
        for (const string& word : wordSet) {
            length += word.size() + 1;
        }
        return length;
    }
};