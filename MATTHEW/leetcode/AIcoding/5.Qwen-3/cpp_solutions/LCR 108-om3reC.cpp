#include <iostream>
#include <vector>
#include <string>
#include <queue>
#include <unordered_set>
#include <unordered_map>

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
        unordered_map<string, bool> visited;
        visited[beginWord] = true;

        while (!q.empty()) {
            auto current = q.front();
            q.pop();
            string word = current.first;
            int level = current.second;

            for (int i = 0; i < word.length(); ++i) {
                char originalChar = word[i];
                for (char c = 'a'; c <= 'z'; ++c) {
                    word[i] = c;
                    if (word == endWord) {
                        return level + 1;
                    }
                    if (wordSet.find(word) != wordSet.end() && !visited[word]) {
                        visited[word] = true;
                        q.push({word, level + 1});
                    }
                }
                word[i] = originalChar;
            }
        }

        return 0;
    }
};