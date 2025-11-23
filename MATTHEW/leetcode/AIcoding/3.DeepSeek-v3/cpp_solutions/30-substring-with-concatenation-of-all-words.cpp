class Solution {
public:
    vector<int> findSubstring(string s, vector<string>& words) {
        vector<int> res;
        if (s.empty() || words.empty()) return res;
        int n = words.size(), len = words[0].size();
        unordered_map<string, int> wordCount;
        for (string word : words) wordCount[word]++;

        for (int i = 0; i <= (int)s.size() - n * len; ++i) {
            unordered_map<string, int> seen;
            int j = 0;
            for (; j < n; ++j) {
                string word = s.substr(i + j * len, len);
                if (wordCount.find(word) != wordCount.end()) {
                    seen[word]++;
                    if (seen[word] > wordCount[word]) break;
                } else break;
            }
            if (j == n) res.push_back(i);
        }
        return res;
    }
};