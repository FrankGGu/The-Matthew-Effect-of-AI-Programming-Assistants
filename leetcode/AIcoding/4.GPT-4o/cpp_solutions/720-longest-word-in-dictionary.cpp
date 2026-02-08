class Solution {
public:
    string longestWord(vector<string>& words) {
        unordered_set<string> wordSet(words.begin(), words.end());
        string longest;

        for (const string& word : words) {
            if (word.size() > longest.size() || (word.size() == longest.size() && word < longest)) {
                bool valid = true;
                for (int i = 1; i < word.size(); i++) {
                    if (!wordSet.count(word.substr(0, i))) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    longest = word;
                }
            }
        }

        return longest;
    }
};