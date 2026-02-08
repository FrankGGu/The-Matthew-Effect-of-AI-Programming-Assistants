#include <iostream>
#include <vector>
#include <unordered_map>
#include <cmath>

using namespace std;

class Solution {
public:
    int countPairs(int n, vector<vector<int>>& edges, int k) {
        unordered_map<int, int> degree;
        vector<vector<int>> adj(n);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].push_back(v);
            adj[v].push_back(u);
            degree[u]++;
            degree[v]++;
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if ((degree[i] * degree[j]) % k == 0) {
                    result++;
                }
            }
        }

        return result;
    }
};