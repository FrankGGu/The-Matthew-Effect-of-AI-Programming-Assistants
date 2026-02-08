#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> findSubstring(string s, vector<string>& words) {
        vector<int> result;
        if (words.empty() || s.empty()) return result;

        int wordLen = words[0].size();
        int totalWords = words.size();
        int totalLen = wordLen * totalWords;
        int sLen = s.size();

        unordered_map<string, int> wordCount;
        for (const string& word : words) {
            wordCount[word]++;
        }

        for (int i = 0; i <= sLen - totalLen; ++i) {
            unordered_map<string, int> seen;
            bool valid = true;
            for (int j = 0; j < totalWords; ++j) {
                int start = i + j * wordLen;
                string currentWord = s.substr(start, wordLen);
                if (wordCount.find(currentWord) == wordCount.end()) {
                    valid = false;
                    break;
                }
                seen[currentWord]++;
                if (seen[currentWord] > wordCount[currentWord]) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                result.push_back(i);
            }
        }

        return result;
    }
};