#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long minimumCost(string source, string target, vector<string>& original, vector<string>& changed, vector<int>& cost) {
        int n = source.size();
        unordered_map<string, int> wordToIndex;
        int wordCount = 0;
        for (const string& s : original) {
            if (wordToIndex.find(s) == wordToIndex.end()) {
                wordToIndex[s] = wordCount++;
            }
        }
        for (const string& s : changed) {
            if (wordToIndex.find(s) == wordToIndex.end()) {
                wordToIndex[s] = wordCount++;
            }
        }

        vector<vector<long long>> adjMatrix(wordCount, vector<long long>(wordCount, LLONG_MAX));
        for (int i = 0; i < wordCount; ++i) {
            adjMatrix[i][i] = 0;
        }

        for (int i = 0; i < original.size(); ++i) {
            int u = wordToIndex[original[i]];
            int v = wordToIndex[changed[i]];
            adjMatrix[u][v] = min(adjMatrix[u][v], (long long)cost[i]);
        }

        for (int k = 0; k < wordCount; ++k) {
            for (int i = 0; i < wordCount; ++i) {
                for (int j = 0; j < wordCount; ++j) {
                    if (adjMatrix[i][k] != LLONG_MAX && adjMatrix[k][j] != LLONG_MAX) {
                        adjMatrix[i][j] = min(adjMatrix[i][j], adjMatrix[i][k] + adjMatrix[k][j]);
                    }
                }
            }
        }

        vector<long long> dp(n + 1, LLONG_MAX);
        dp[0] = 0;

        for (int i = 0; i < n; ++i) {
            if (dp[i] == LLONG_MAX) continue;

            if (source[i] == target[i]) {
                dp[i + 1] = min(dp[i + 1], dp[i]);
            } else {
                dp[i + 1] = min(dp[i + 1], dp[i] + (long long)(source[i] != target[i]));
            }

            for (int j = 0; j < original.size(); ++j) {
                string orig = original[j];
                if (i + orig.size() <= n && source.substr(i, orig.size()) == orig) {
                    string chng = changed[j];
                    if (target.substr(i, chng.size()) == chng) {
                        int u = wordToIndex[orig];
                        int v = wordToIndex[chng];
                        if (adjMatrix[u][v] != LLONG_MAX) {
                            dp[i + orig.size()] = min(dp[i + orig.size()], dp[i] + adjMatrix[u][v]);
                        }
                    }
                }
            }
        }

        return (dp[n] == LLONG_MAX) ? -1 : dp[n];
    }
};