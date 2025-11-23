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
            if (isMatch(word, pattern)) {
                result.push_back(word);
            }
        }
        return result;
    }

private:
    bool isMatch(const string& word, const string& pattern) {
        if (word.size() != pattern.size()) {
            return false;
        }

        unordered_map<char, char> wordToPattern;
        unordered_map<char, char> patternToWord;

        for (size_t i = 0; i < word.size(); ++i) {
            char w = word[i];
            char p = pattern[i];

            if (wordToPattern.find(w) != wordToPattern.end()) {
                if (wordToPattern[w] != p) {
                    return false;
                }
            } else {
                if (patternToWord.find(p) != patternToWord.end()) {
                    return false;
                }
                wordToPattern[w] = p;
                patternToWord[p] = w;
            }
        }

        return true;
    }
};