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
        unordered_map<char, char> w_to_p, p_to_w;
        for (int i = 0; i < word.size(); ++i) {
            char w_char = word[i];
            char p_char = pattern[i];
            if ((w_to_p.count(w_char) && w_to_p[w_char] != p_char) || 
                (p_to_w.count(p_char) && p_to_w[p_char] != w_char)) ) {
                return false;
            }
            w_to_p[w_char] = p_char;
            p_to_w[p_char] = w_char;
        }
        return true;
    }
};