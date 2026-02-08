#include <string>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int ladderLength(string beginWord, string endWord, vector<string>& wordList) {
        unordered_set<string> wordSet(wordList.begin(), wordList.end());
        if (wordSet.find(endWord) == wordSet.end()) {
            return 0;
        }

        queue<pair<string, int>> q;
        q.push({beginWord, 1});
        wordSet.erase(beginWord);

        while (!q.empty()) {
            string currentWord = q.front().first;
            int currentLength = q.front().second;
            q.pop();

            if (currentWord == endWord) {
                return currentLength;
            }

            for (int i = 0; i < currentWord.length(); ++i) {
                char originalChar = currentWord[i];
                for (char c = 'a'; c <= 'z'; ++c) {
                    currentWord[i] = c;
                    if (wordSet.find(currentWord) != wordSet.end()) {
                        q.push({currentWord, currentLength + 1});
                        wordSet.erase(currentWord);
                    }
                }
                currentWord[i] = originalChar;
            }
        }

        return 0;
    }
};