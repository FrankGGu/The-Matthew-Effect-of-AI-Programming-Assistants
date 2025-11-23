#include <vector>
#include <string>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string alienOrder(vector<string>& words) {
        unordered_map<char, vector<char>> adj;
        unordered_map<char, int> inDegree;
        string result = "";

        for (const string& word : words) {
            for (char c : word) {
                inDegree[c] = 0;
            }
        }

        for (int i = 0; i < words.size() - 1; ++i) {
            string word1 = words[i];
            string word2 = words[i + 1];
            int minLen = min(word1.length(), word2.length());

            for (int j = 0; j < minLen; ++j) {
                if (word1[j] != word2[j]) {
                    if (find(adj[word1[j]].begin(), adj[word1[j]].end(), word2[j]) == adj[word1[j]].end()) {
                        adj[word1[j]].push_back(word2[j]);
                        inDegree[word2[j]]++;
                    }
                    break;
                }
                if (j == minLen - 1 && word1.length() > word2.length()) {
                    return "";
                }
            }
        }

        queue<char> q;
        for (auto const& [key, val] : inDegree) {
            if (val == 0) {
                q.push(key);
            }
        }

        while (!q.empty()) {
            char c = q.front();
            q.pop();
            result += c;

            for (char neighbor : adj[c]) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        if (result.length() != inDegree.size()) {
            return "";
        }

        return result;
    }
};