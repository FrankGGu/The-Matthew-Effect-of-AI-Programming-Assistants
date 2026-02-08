#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> findAndReplacePattern(vector<string>& words, string pattern) {
        vector<string> result;
        for (const string& word : words) {
            if (word.length() == pattern.length()) {
                if (matches(word, pattern)) {
                    result.push_back(word);
                }
            }
        }
        return result;
    }

private:
    bool matches(const string& word, const string& pattern) {
        unordered_map<char, char> w2p;
        unordered_map<char, char> p2w;

        for (size_t i = 0; i < word.length(); ++i) {
            char w = word[i];
            char p = pattern[i];

            if (w2p.find(w) == w2p.end() && p2w.find(p) == p2w.end()) {
                w2p[w] = p;
                p2w[p] = w;
            } else if (w2p.find(w) != w2p.end() && p2w.find(p) != p2w.end()) {
                if (w2p[w] != p || p2w[p] != w) {
                    return false;
                }
            } else {
                return false;
            }
        }
        return true;
    }
};