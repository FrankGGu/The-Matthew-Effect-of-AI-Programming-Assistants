#include <iostream>
#include <vector>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> getAncestors(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        vector<vector<int>> result(n);

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
        }

        for (int i = 0; i < n; ++i) {
            queue<int> q;
            unordered_set<int> visited;
            for (int neighbor : adj[i]) {
                q.push(neighbor);
                visited.insert(neighbor);
            }
            while (!q.empty()) {
                int node = q.front();
                q.pop();
                result[node].push_back(i);
                for (int neighbor : adj[node]) {
                    if (visited.find(neighbor) == visited.end()) {
                        visited.insert(neighbor);
                        q.push(neighbor);
                    }
                }
            }
        }

        return result;
    }
};