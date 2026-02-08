#include <iostream>
#include <vector>
#include <map>
#include <string>

using namespace std;

class Solution {
public:
    bool wordPattern(string pattern, string s) {
        vector<string> words;
        string word;
        for (char c : s) {
            if (c == ' ') {
                words.push_back(word);
                word.clear();
            } else {
                word += c;
            }
        }
        words.push_back(word);

        if (pattern.length() != words.size()) {
            return false;
        }

        map<char, string> p_to_word;
        map<string, char> word_to_p;

        for (int i = 0; i < pattern.length(); ++i) {
            char p = pattern[i];
            string w = words[i];

            if (p_to_word.find(p) != p_to_word.end()) {
                if (p_to_word[p] != w) {
                    return false;
                }
            } else {
                if (word_to_p.find(w) != word_to_p.end()) {
                    return false;
                }
                p_to_word[p] = w;
                word_to_p[w] = p;
            }
        }

        return true;
    }
};