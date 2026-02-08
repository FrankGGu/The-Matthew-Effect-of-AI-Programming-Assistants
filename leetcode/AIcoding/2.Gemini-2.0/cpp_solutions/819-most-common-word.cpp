#include <string>
#include <vector>
#include <sstream>
#include <unordered_map>
#include <algorithm>
#include <cctype>

using namespace std;

class Solution {
public:
    string mostCommonWord(string paragraph, vector<string>& banned) {
        unordered_map<string, int> wordCount;
        unordered_map<string, bool> bannedWords;
        for (const string& word : banned) {
            bannedWords[word] = true;
        }

        string word;
        string result;
        int maxCount = 0;

        for (char c : paragraph) {
            if (isalpha(c)) {
                word += tolower(c);
            } else {
                if (!word.empty()) {
                    if (!bannedWords[word]) {
                        wordCount[word]++;
                        if (wordCount[word] > maxCount) {
                            maxCount = wordCount[word];
                            result = word;
                        }
                    }
                    word = "";
                }
            }
        }

        if (!word.empty()) {
            if (!bannedWords[word]) {
                wordCount[word]++;
                if (wordCount[word] > maxCount) {
                    maxCount = wordCount[word];
                    result = word;
                }
            }
        }

        return result;
    }
};