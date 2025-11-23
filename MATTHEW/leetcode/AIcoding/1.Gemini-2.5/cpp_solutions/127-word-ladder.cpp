#include <string>
#include <vector>
#include <queue>
#include <unordered_set>
#include <algorithm>

class Solution {
public:
    int ladderLength(std::string beginWord, std::string endWord, std::vector<std::string>& wordList) {
        std::unordered_set<std::string> wordSet(wordList.begin(), wordList.end());

        if (wordSet.find(endWord) == wordSet.end()) {
            return 0;
        }

        std::queue<std::pair<std::string, int>> q;
        q.push({beginWord, 1});

        std::unordered_set<std::string> visited;
        visited.insert(beginWord);

        while (!q.empty()) {
            std::string currentWord = q.front().first;
            int currentLevel = q.front().second;
            q.pop();

            if (currentWord == endWord) {
                return currentLevel;
            }

            for (int i = 0; i < currentWord.length(); ++i) {
                char originalChar = currentWord[i];
                for (char c = 'a'; c <= 'z'; ++c) {
                    if (c == originalChar) continue;
                    currentWord[i] = c;

                    if (wordSet.count(currentWord) && !visited.count(currentWord)) {
                        visited.insert(currentWord);
                        q.push({currentWord, currentLevel + 1});
                    }
                }
                currentWord[i] = originalChar; // Backtrack
            }
        }

        return 0;
    }
};