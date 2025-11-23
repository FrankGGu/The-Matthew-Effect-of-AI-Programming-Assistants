#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    string alienOrder(vector<string>& words) {
        unordered_map<char, vector<char>> graph;
        unordered_map<char, int> inDegree;

        for (const string& word : words) {
            for (char c : word) {
                inDegree[c] = 0;
            }
        }

        for (int i = 0; i < words.size() - 1; ++i) {
            string word1 = words[i];
            string word2 = words[i + 1];

            int minLen = min(word1.length(), word2.length());
            bool isDifferent = false;

            for (int j = 0; j < minLen; ++j) {
                char c1 = word1[j];
                char c2 = word2[j];

                if (c1 != c2) {
                    graph[c1].push_back(c2);
                    inDegree[c2]++;
                    isDifferent = true;
                    break;
                }
            }

            if (!isDifferent && word1.length() > word2.length()) {
                return "";
            }
        }

        queue<char> q;
        for (auto& pair : inDegree) {
            if (pair.second == 0) {
                q.push(pair.first);
            }
        }

        string result;
        while (!q.empty()) {
            char c = q.front();
            q.pop();
            result += c;

            for (char neighbor : graph[c]) {
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