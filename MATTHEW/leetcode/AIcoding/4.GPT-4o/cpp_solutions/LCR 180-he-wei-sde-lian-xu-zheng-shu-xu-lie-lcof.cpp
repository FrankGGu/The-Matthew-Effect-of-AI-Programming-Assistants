class Solution {
public:
    vector<string> findAndReplacePattern(vector<string>& words, string pattern) {
        vector<string> result;
        for (const string& word : words) {
            if (matches(word, pattern)) {
                result.push_back(word);
            }
        }
        return result;
    }

private:
    bool matches(const string& word, const string& pattern) {
        unordered_map<char, char> w2p, p2w;
        for (int i = 0; i < word.size(); ++i) {
            char w = word[i], p = pattern[i];
            if (w2p.count(w) == 0) w2p[w] = p;
            if (p2w.count(p) == 0) p2w[p] = w;
            if (w2p[w] != p || p2w[p] != w) return false;
        }
        return true;
    }
};