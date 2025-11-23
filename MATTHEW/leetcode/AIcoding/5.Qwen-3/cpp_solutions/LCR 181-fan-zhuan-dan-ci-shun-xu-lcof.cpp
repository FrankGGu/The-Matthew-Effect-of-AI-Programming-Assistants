#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string reverseWords(string s) {
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
        string result;
        for (int i = words.size() - 1; i >= 0; --i) {
            result += words[i];
            if (i > 0) {
                result += ' ';
            }
        }
        return result;
    }
};