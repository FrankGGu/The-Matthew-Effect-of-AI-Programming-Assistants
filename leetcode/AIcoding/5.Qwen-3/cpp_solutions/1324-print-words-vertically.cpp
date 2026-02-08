#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> printWordsVertically(string s) {
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
        if (!word.empty()) {
            words.push_back(word);
        }

        int maxLen = 0;
        for (const string& w : words) {
            maxLen = max(maxLen, (int)w.size());
        }

        vector<string> result;
        for (int i = 0; i < maxLen; ++i) {
            string line;
            for (const string& w : words) {
                if (i < w.size()) {
                    line += w[i];
                } else {
                    line += ' ';
                }
            }
                        while (!line.empty() && line.back() == ' ') {
                line.pop_back();
            }
            result.push_back(line);
        }

        return result;
    }
};