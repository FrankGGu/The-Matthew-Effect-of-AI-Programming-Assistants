#include <iostream>
#include <vector>
#include <unordered_map>
#include <set>
#include <climits>

using namespace std;

class Solution {
public:
    int minTrio(int n, vector<vector<int>>& edges) {
        vector<set<int>> adj(n + 1);
        for (const auto& edge : edges) {
            adj[edge[0]].insert(edge[1]);
            adj[edge[1]].insert(edge[0]);
        }

        int minDegree = INT_MAX;

        for (int i = 1; i <= n; ++i) {
            for (int j : adj[i]) {
                if (j > i) {
                    for (int k : adj[j]) {
                        if (k > j && adj[i].count(k)) {
                            int degree = adj[i].size() + adj[j].size() + adj[k].size() - 3;
                            minDegree = min(minDegree, degree);
                        }
                    }
                }
            }
        }

        return minDegree == INT_MAX ? 0 : minDegree;
    }
};