#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> findAndReplacePattern(vector<string>& words, string pattern) {
        vector<string> result;
        for (const string& word : words) {
            if (word.length() != pattern.length()) {
                continue;
            }
            unordered_map<char, char> wordToPattern;
            unordered_map<char, char> patternToWord;
            bool match = true;
            for (int i = 0; i < word.length(); ++i) {
                char w = word[i];
                char p = pattern[i];
                if (wordToPattern.find(w) == wordToPattern.end() && patternToWord.find(p) == patternToWord.end()) {
                    wordToPattern[w] = p;
                    patternToWord[p] = w;
                } else if (wordToPattern.find(w) != wordToPattern.end() && patternToWord.find(p) != patternToWord.end()) {
                    if (wordToPattern[w] != p || patternToWord[p] != w) {
                        match = false;
                        break;
                    }
                } else {
                    match = false;
                    break;
                }
            }
            if (match) {
                result.push_back(word);
            }
        }
        return result;
    }
};