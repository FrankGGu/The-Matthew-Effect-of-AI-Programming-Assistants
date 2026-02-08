class Solution {
public:
    int wordCount(vector<string>& startWords, vector<string>& targetWords) {
        unordered_set<string> seen;
        for (string word : startWords) {
            sort(word.begin(), word.end());
            seen.insert(word);
        }

        int count = 0;
        for (string word : targetWords) {
            sort(word.begin(), word.end());
            for (int i = 0; i < word.size(); ++i) {
                string candidate = word.substr(0, i) + word.substr(i + 1);
                if (seen.count(candidate)) {
                    ++count;
                    break;
                }
            }
        }
        return count;
    }
};