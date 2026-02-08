#include <iostream>
#include <vector>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    int reachableNodes(vector<int>& edges, int n, vector<int>& restricted) {
        unordered_set<int> restrictSet(restricted.begin(), restricted.end());
        vector<vector<int>> graph(n);
        for (int i = 0; i < edges.size(); i += 2) {
            int u = edges[i];
            int v = edges[i + 1];
            graph[u].push_back(v);
            graph[v].push_back(u);
        }

        vector<bool> visited(n, false);
        queue<int> q;
        q.push(0);
        visited[0] = true;
        int count = 0;

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            count++;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor] && restrictSet.find(neighbor) == restrictSet.end()) {
                    visited[neighbor] = true;
                    q.push(neighbor);
                }
            }
        }

        return count;
    }
};