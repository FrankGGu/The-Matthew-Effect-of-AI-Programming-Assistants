#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> findLadders(int n, string beginWord, string endWord, vector<string>& wordList) {
        unordered_set<string> wordSet(wordList.begin(), wordList.end());
        if (wordSet.find(endWord) == wordSet.end()) return {};
        unordered_map<string, vector<string>> next;
        bool found = false;
        queue<string> q;
        q.push(beginWord);
        unordered_map<string, int> dist;
        dist[beginWord] = 1;
        while (!q.empty() && !found) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                string curr = q.front();
                q.pop();
                for (int j = 0; j < curr.size(); ++j) {
                    char original = curr[j];
                    for (char c = 'a'; c <= 'z'; ++c) {
                        if (c == original) continue;
                        curr[j] = c;
                        if (wordSet.find(curr) != wordSet.end()) {
                            if (dist.find(curr) == dist.end()) {
                                dist[curr] = dist[curr] + 1;
                                q.push(curr);
                            }
                            if (dist[curr] == dist[original] + 1) {
                                next[original].push_back(curr);
                            }
                            if (curr == endWord) {
                                found = true;
                            }
                        }
                    }
                    curr[j] = original;
                }
            }
        }
        vector<vector<string>> result;
        vector<string> path;
        path.push_back(beginWord);
        dfs(beginWord, endWord, next, path, result);
        return result;
    }

private:
    void dfs(string curr, string endWord, unordered_map<string, vector<string>>& next, vector<string>& path, vector<vector<string>>& result) {
        if (curr == endWord) {
            result.push_back(path);
            return;
        }
        for (string& nextWord : next[curr]) {
            path.push_back(nextWord);
            dfs(nextWord, endWord, next, path, result);
            path.pop_back();
        }
    }
};