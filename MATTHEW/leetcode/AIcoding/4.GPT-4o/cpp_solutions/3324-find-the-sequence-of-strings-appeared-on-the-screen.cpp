class Solution {
public:
    vector<string> findSequences(string s, vector<string>& words) {
        unordered_map<string, int> wordCount;
        for (const string& word : words) {
            wordCount[word]++;
        }

        vector<string> result;
        int n = s.size();
        int m = words.size();
        int wordLength = words[0].size();

        for (int i = 0; i <= n - m * wordLength; i++) {
            unordered_map<string, int> seen;
            int j = 0;
            while (j < m) {
                string word = s.substr(i + j * wordLength, wordLength);
                if (wordCount.find(word) == wordCount.end()) break;
                seen[word]++;
                if (seen[word] > wordCount[word]) break;
                j++;
            }
            if (j == m) result.push_back(s.substr(i, m * wordLength));
        }

        return result;
    }
};