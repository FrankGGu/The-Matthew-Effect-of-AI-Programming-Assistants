#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minReorder(int n, vector<vector<int>>& connections) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& conn : connections) {
            int u = conn[0], v = conn[1];
            graph[u].push_back({v, 1});
            graph[v].push_back({u, 0});
        }

        vector<bool> visited(n, false);
        queue<int> q;
        q.push(0);
        visited[0] = true;
        int count = 0;

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            for (auto& [neighbor, direction] : graph[node]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    q.push(neighbor);
                    if (direction == 1) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
};