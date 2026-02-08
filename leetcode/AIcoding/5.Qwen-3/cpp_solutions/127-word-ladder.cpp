#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>
#include <string>

using namespace std;

class Solution {
public:
    int ladderLength(string beginWord, string endWord, vector<string>& wordList) {
        unordered_set<string> wordSet(wordList.begin(), wordList.end());
        if (wordSet.find(endWord) == wordSet.end()) return 0;

        queue<pair<string, int>> q;
        q.push({beginWord, 1});
        wordSet.erase(beginWord);

        while (!q.empty()) {
            auto [currentWord, level] = q.front();
            q.pop();

            for (int i = 0; i < currentWord.size(); ++i) {
                char originalChar = currentWord[i];
                for (char ch = 'a'; ch <= 'z'; ++ch) {
                    currentWord[i] = ch;
                    if (currentWord == endWord) return level + 1;
                    if (wordSet.find(currentWord) != wordSet.end()) {
                        q.push({currentWord, level + 1});
                        wordSet.erase(currentWord);
                    }
                }
                currentWord[i] = originalChar;
            }
        }

        return 0;
    }
};