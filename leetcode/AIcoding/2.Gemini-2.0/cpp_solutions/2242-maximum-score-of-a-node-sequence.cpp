#include <vector>
#include <algorithm>

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
            if (adj[i].size() > 3) {
                adj[i].resize(3);
            }
        }

        int max_score = -1;
        for (auto& edge : edges) {
            int a = edge[0];
            int b = edge[1];
            for (int c : adj[a]) {
                if (c == b) continue;
                for (int d : adj[b]) {
                    if (d == a || d == c) continue;
                    max_score = max(max_score, scores[a] + scores[b] + scores[c] + scores[d]);
                }
            }
        }

        return max_score;
    }
};