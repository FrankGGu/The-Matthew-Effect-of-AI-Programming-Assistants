#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> findMinHeightTrees(int n, vector<vector<int>>& edges) {
        if (n == 1) return {0};

        vector<unordered_map<int, int>> adj(n);
        vector<int> degree(n, 0);

        for (const auto& edge : edges) {
            adj[edge[0]][edge[1]] = 1;
            adj[edge[1]][edge[0]] = 1;
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        queue<int> leaves;
        for (int i = 0; i < n; ++i) {
            if (degree[i] == 1) {
                leaves.push(i);
            }
        }

        int remainingNodes = n;
        while (remainingNodes > 2) {
            int leavesSize = leaves.size();
            for (int i = 0; i < leavesSize; ++i) {
                int leaf = leaves.front();
                leaves.pop();
                for (auto& neighbor : adj[leaf]) {
                    degree[neighbor.first]--;
                    if (degree[neighbor.first] == 1) {
                        leaves.push(neighbor.first);
                    }
                }
                remainingNodes--;
            }
        }

        vector<int> result;
        while (!leaves.empty()) {
            result.push_back(leaves.front());
            leaves.pop();
        }

        return result;
    }
};