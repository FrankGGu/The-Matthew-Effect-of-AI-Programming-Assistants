#include <string>
#include <sstream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool wordPattern(string pattern, string s) {
        unordered_map<char, string> char_to_word;
        unordered_map<string, char> word_to_char;

        vector<string> words;
        stringstream ss(s);
        string word;
        while (ss >> word) {
            words.push_back(word);
        }

        if (pattern.length() != words.size()) {
            return false;
        }

        for (int i = 0; i < pattern.length(); ++i) {
            char c = pattern[i];
            string w = words[i];

            if (char_to_word.find(c) == char_to_word.end() && word_to_char.find(w) == word_to_char.end()) {
                char_to_word[c] = w;
                word_to_char[w] = c;
            } else if (char_to_word.find(c) != char_to_word.end() && word_to_char.find(w) != word_to_char.end()) {
                if (char_to_word[c] != w || word_to_char[w] != c) {
                    return false;
                }
            } else {
                return false;
            }
        }

        return true;
    }
};