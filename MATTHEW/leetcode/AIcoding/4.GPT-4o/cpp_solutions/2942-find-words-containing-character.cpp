class Solution {
public:
    vector<string> findWords(vector<string>& words, string chars) {
        vector<int> charCount(26, 0);
        for (char c : chars) {
            charCount[c - 'a']++;
        }

        vector<string> result;
        for (const string& word : words) {
            vector<int> wordCount(26, 0);
            bool canForm = true;
            for (char c : word) {
                wordCount[c - 'a']++;
                if (wordCount[c - 'a'] > charCount[c - 'a']) {
                    canForm = false;
                    break;
                }
            }
            if (canForm) {
                result.push_back(word);
            }
        }

        return result;
    }
};