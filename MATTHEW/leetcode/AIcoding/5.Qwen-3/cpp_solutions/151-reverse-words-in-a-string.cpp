#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    void reverseWords(string &s) {
        vector<string> words;
        string word;
        for (char c : s) {
            if (c == ' ') {
                if (!word.empty()) {
                    words.push_back(word);
                    word.clear();
                }
            } else {
                word += c;
            }
        }
        if (!word.empty()) {
            words.push_back(word);
        }
        s.clear();
        for (int i = words.size() - 1; i >= 0; --i) {
            s += words[i];
            if (i > 0) {
                s += ' ';
            }
        }
    }
};