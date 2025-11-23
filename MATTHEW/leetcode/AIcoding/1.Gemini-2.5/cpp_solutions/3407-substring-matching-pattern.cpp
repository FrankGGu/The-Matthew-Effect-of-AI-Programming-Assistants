#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> findAndReplacePattern(vector<string>& words, string pattern) {
        vector<string> res;
        for (string& word : words) {
            if (word.length() != pattern.length()) continue;
            if (match(word, pattern)) {
                res.push_back(word);
            }
        }
        return res;
    }

private:
    bool match(string& word, string& pattern) {
        unordered_map<char, char> w2p;
        unordered_map<char, char> p2w;
        for (int i = 0; i < word.length(); ++i) {
            char w = word[i];
            char p = pattern[i];
            if (w2p.find(w) == w2p.end() && p2w.find(p) == p2w.end()) {
                w2p[w] = p;
                p2w[p] = w;
            } else if (w2p.find(w) != w2p.end() && p2w.find(p) != p2w.end()) {
                if (w2p[w] != p || p2w[p] != w) return false;
            } else {
                return false;
            }
        }
        return true;
    }
};