#include <iostream>
#include <vector>
#include <unordered_map>
#include <cmath>

using namespace std;

class Solution {
public:
    int numberOfWays(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        unordered_map<int, int> degree;
        for (int i = 0; i < n; ++i) {
            degree[i] = adj[i].size();
        }

        vector<int> degrees;
        for (const auto& [node, d] : degree) {
            degrees.push_back(d);
        }

        sort(degrees.begin(), degrees.end());

        int res = 1;
        for (int i = 0; i < n - 1; ++i) {
            if (degrees[i] != i + 1) {
                return 0;
            }
        }

        for (int i = 0; i < n - 1; ++i) {
            res = (long long)res * (n - 1 - i) % 1000000007;
        }

        return res;
    }
};