#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int profitablePath(vector<vector<int>>& g, vector<int>& p) {
        unordered_map<int, vector<int>> adj;
        for (auto& edge : g) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        int res = 0;
        function<int(int, int)> dfs = [&](int node, int parent) -> int {
            int maxProfit = 0;
            for (int neighbor : adj[node]) {
                if (neighbor != parent) {
                    maxProfit = max(maxProfit, dfs(neighbor, node));
                }
            }
            return maxProfit + p[node];
        };

        function<void(int, int, int)> traverse = [&](int node, int parent, int currentProfit) {
            currentProfit += p[node];
            bool isLeaf = true;
            for (int neighbor : adj[node]) {
                if (neighbor != parent) {
                    isLeaf = false;
                    traverse(neighbor, node, currentProfit);
                }
            }
            if (isLeaf) {
                res = max(res, currentProfit);
            }
        };

        traverse(0, -1, 0);
        return res;
    }
};