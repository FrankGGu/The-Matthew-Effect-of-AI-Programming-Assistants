#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int isPrefixOfWord(string sentence, string word) {
        vector<string> words;
        string current;
        for (char c : sentence) {
            if (c == ' ') {
                words.push_back(current);
                current = "";
            } else {
                current += c;
            }
        }
        words.push_back(current);

        for (int i = 0; i < words.size(); ++i) {
            if (words[i].size() >= word.size() && words[i].substr(0, word.size()) == word) {
                return i + 1;
            }
        }
        return -1;
    }
};