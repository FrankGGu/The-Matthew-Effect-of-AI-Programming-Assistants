#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> findAndReplacePattern(vector<string>& words, string pattern) {
        vector<string> result;
        for (const string& word : words) {
            if (word.length() == pattern.length() && matches(word, pattern)) {
                result.push_back(word);
            }
        }
        return result;
    }

private:
    bool matches(const string& word, const string& pattern) {
        unordered_map<char, char> patternToWord;
        unordered_map<char, char> wordToPattern;

        for (size_t i = 0; i < word.length(); ++i) {
            char w = word[i];
            char p = pattern[i];

            if (patternToWord.find(p) == patternToWord.end() && wordToPattern.find(w) == wordToPattern.end()) {
                patternToWord[p] = w;
                wordToPattern[w] = p;
            } else if (patternToWord.find(p) != patternToWord.end() && wordToPattern.find(w) != wordToPattern.end()) {
                if (patternToWord[p] != w || wordToPattern[w] != p) {
                    return false;
                }
            } else {
                return false;
            }
        }
        return true;
    }
};