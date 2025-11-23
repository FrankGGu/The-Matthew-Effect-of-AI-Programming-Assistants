#include <string>
#include <vector>
#include <queue>
#include <unordered_set>

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
            string currWord = q.front().first;
            int currLevel = q.front().second;
            q.pop();

            if (currWord == endWord) return currLevel;

            for (int i = 0; i < currWord.length(); ++i) {
                char originalChar = currWord[i];
                for (char c = 'a'; c <= 'z'; ++c) {
                    currWord[i] = c;
                    if (wordSet.find(currWord) != wordSet.end()) {
                        q.push({currWord, currLevel + 1});
                        wordSet.erase(currWord);
                    }
                }
                currWord[i] = originalChar;
            }
        }

        return 0;
    }
};