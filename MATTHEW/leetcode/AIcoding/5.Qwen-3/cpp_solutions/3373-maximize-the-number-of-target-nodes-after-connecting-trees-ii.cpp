#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int connectTrees(int n, vector<vector<int>>& edges, vector<int>& targetNodes) {
        unordered_map<int, vector<int>> graph;
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        queue<int> q;
        for (int node : targetNodes) {
            q.push(node);
            visited[node] = true;
        }

        while (!q.empty()) {
            int current = q.front();
            q.pop();
            for (int neighbor : graph[current]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    q.push(neighbor);
                }
            }
        }

        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (visited[i]) {
                ++count;
            }
        }

        return count;
    }
};