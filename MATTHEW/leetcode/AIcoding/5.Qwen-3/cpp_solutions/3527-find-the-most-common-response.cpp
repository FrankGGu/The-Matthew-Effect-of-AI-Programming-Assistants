#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int mostCommonWord(std::vector<std::string>& paragraph, std::vector<std::string>& banned) {
        std::unordered_map<std::string, int> wordCount;
        std::unordered_set<std::string> bannedSet(banned.begin(), banned.end());

        std::string word;
        for (char c : paragraph) {
            if (isalpha(c)) {
                word += tolower(c);
            } else if (!word.empty()) {
                if (bannedSet.find(word) == bannedSet.end()) {
                    wordCount[word]++;
                }
                word.clear();
            }
        }
        if (!word.empty() && bannedSet.find(word) == bannedSet.end()) {
            wordCount[word]++;
        }

        int maxCount = 0;
        std::string mostCommon;
        for (const auto& pair : wordCount) {
            if (pair.second > maxCount) {
                maxCount = pair.second;
                mostCommon = pair.first;
            }
        }

        return mostCommon;
    }
};