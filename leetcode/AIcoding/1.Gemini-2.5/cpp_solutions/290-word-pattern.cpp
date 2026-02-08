#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool wordPattern(string pattern, string s) {
        unordered_map<char, string> charToWord;
        unordered_map<string, char> wordToChar;

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

            if (charToWord.find(c) == charToWord.end() && wordToChar.find(w) == wordToChar.end()) {
                charToWord[c] = w;
                wordToChar[w] = c;
            } else if (charToWord.find(c) != charToWord.end() && wordToChar.find(w) != wordToChar.end()) {
                if (charToWord[c] != w || wordToChar[w] != c) {
                    return false;
                }
            } else {
                return false;
            }
        }

        return true;
    }
};