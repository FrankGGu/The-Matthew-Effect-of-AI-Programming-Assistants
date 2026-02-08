#include <string>
#include <vector>
#include <unordered_map>
#include <sstream>
#include <algorithm>

using namespace std;

class Solution {
public:
    string mostCommonWord(string paragraph, vector<string>& banned) {
        unordered_map<string, int> wordCount;
        unordered_set<string> bannedSet(banned.begin(), banned.end());
        string word;
        paragraph += " "; // To capture the last word

        for (char& c : paragraph) {
            if (isalpha(c)) {
                c = tolower(c);
            } else if (c == ' ' && !word.empty()) {
                if (bannedSet.find(word) == bannedSet.end()) {
                    wordCount[word]++;
                }
                word.clear();
            } else {
                continue;
            }
            if (isalpha(c)) {
                word += c;
            }
        }

        string mostCommon;
        int maxCount = 0;

        for (const auto& wc : wordCount) {
            if (wc.second > maxCount) {
                maxCount = wc.second;
                mostCommon = wc.first;
            }
        }

        return mostCommon;
    }
};