#include <string>
#include <vector>
#include <queue>
#include <unordered_set>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<string>> findLadders(string beginWord, string endWord, vector<string>& wordList) {
        unordered_set<string> wordSet(wordList.begin(), wordList.end());
        if (wordSet.find(endWord) == wordSet.end()) {
            return {};
        }

        unordered_map<string, vector<string>> adj;
        unordered_map<string, int> distance;
        queue<string> q;

        wordSet.insert(beginWord);
        distance[beginWord] = 0;
        q.push(beginWord);

        while (!q.empty()) {
            string curr = q.front();
            q.pop();

            string temp = curr;
            for (int i = 0; i < temp.size(); ++i) {
                char originalChar = temp[i];
                for (char c = 'a'; c <= 'z'; ++c) {
                    temp[i] = c;
                    if (wordSet.find(temp) != wordSet.end()) {
                        if (distance.find(temp) == distance.end()) {
                            distance[temp] = distance[curr] + 1;
                            q.push(temp);
                            adj[curr].push_back(temp);
                        } else if (distance[temp] == distance[curr] + 1) {
                            adj[curr].push_back(temp);
                        }
                    }
                }
                temp[i] = originalChar;
            }
        }

        vector<vector<string>> result;
        vector<string> path;
        path.push_back(beginWord);
        dfs(beginWord, endWord, adj, path, result);

        return result;
    }

private:
    void dfs(string curr, string endWord, unordered_map<string, vector<string>>& adj, vector<string>& path, vector<vector<string>>& result) {
        if (curr == endWord) {
            result.push_back(path);
            return;
        }

        if (adj.find(curr) == adj.end()) {
            return;
        }

        for (string next : adj[curr]) {
            path.push_back(next);
            dfs(next, endWord, adj, path, result);
            path.pop_back();
        }
    }
};