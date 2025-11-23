#include <vector>
#include <string>
#include <unordered_set>
#include <unordered_map>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> findLadders(string beginWord, string endWord, vector<string>& wordList) {
        unordered_set<string> wordSet(wordList.begin(), wordList.end());
        vector<vector<string>> result;
        unordered_map<string, vector<string>> graph;
        queue<string> q;

        if (wordSet.find(endWord) == wordSet.end()) return result;

        q.push(beginWord);
        wordSet.erase(beginWord);
        bool found = false;

        while (!q.empty() && !found) {
            unordered_set<string> visitedThisLevel;
            int size = q.size();
            for (int i = 0; i < size; i++) {
                string word = q.front();
                q.pop();
                string temp = word;

                for (int j = 0; j < temp.size(); j++) {
                    char originalChar = temp[j];
                    for (char c = 'a'; c <= 'z'; c++) {
                        if (c == originalChar) continue;
                        temp[j] = c;
                        if (wordSet.find(temp) != wordSet.end()) {
                            graph[word].push_back(temp);
                            visitedThisLevel.insert(temp);
                            if (temp == endWord) found = true;
                        }
                    }
                    temp[j] = originalChar;
                }
            }
            for (const string& word : visitedThisLevel) {
                wordSet.erase(word);
            }
            for (const string& word : visitedThisLevel) {
                q.push(word);
            }
        }

        vector<string> path = {beginWord};
        backtrack(beginWord, endWord, graph, path, result);
        return result;
    }

    void backtrack(string word, string& endWord, unordered_map<string, vector<string>>& graph, vector<string>& path, vector<vector<string>>& result) {
        if (word == endWord) {
            result.push_back(path);
            return;
        }
        for (const string& next : graph[word]) {
            path.push_back(next);
            backtrack(next, endWord, graph, path, result);
            path.pop_back();
        }
    }
};