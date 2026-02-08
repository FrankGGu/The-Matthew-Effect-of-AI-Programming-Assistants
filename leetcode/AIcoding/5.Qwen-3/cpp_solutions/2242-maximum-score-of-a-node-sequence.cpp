#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int maximumScore(vector<int>& scores, vector<vector<int>>& edges) {
        int n = scores.size();
        vector<vector<int>> adj(n);

        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        for (int i = 0; i < n; ++i) {
            sort(adj[i].begin(), adj[i].end(), [&](int a, int b) {
                return scores[a] > scores[b];
            });
        }

        int maxScore = -1;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < min(3, (int)adj[i].size()); ++j) {
                int u = adj[i][j];
                for (int k = 0; k < min(3, (int)adj[u].size()); ++k) {
                    int v = adj[u][k];
                    if (v != i) {
                        maxScore = max(maxScore, scores[i] + scores[u] + scores[v]);
                    }
                }
            }
        }

        return maxScore;
    }
};