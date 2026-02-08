#include <string>
#include <vector>
#include <queue>
#include <unordered_set>
#include <utility> // For std::pair

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
            int level = q.front().second;
            q.pop();

            if (currentWord == endWord) {
                return level;
            }

            for (int i = 0; i < currentWord.length(); ++i) {
                char originalChar = currentWord[i];
                for (char c = 'a'; c <= 'z'; ++c) {
                    if (c == originalChar) continue;
                    currentWord[i] = c;
                    if (wordSet.count(currentWord) && visited.find(currentWord) == visited.end()) {
                        visited.insert(currentWord);
                        q.push({currentWord, level + 1});
                    }
                }
                currentWord[i] = originalChar;
            }
        }

        return 0;
    }
};