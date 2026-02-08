#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int reachableNodes(int n, vector<vector<int>>& edges, vector<int>& restricted) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        unordered_set<int> restrictedSet(restricted.begin(), restricted.end());
        vector<bool> visited(n, false);
        queue<int> q;
        q.push(0);
        visited[0] = true;

        int count = 0;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            count++;

            for (int v : adj[u]) {
                if (!visited[v] && restrictedSet.find(v) == restrictedSet.end()) {
                    visited[v] = true;
                    q.push(v);
                }
            }
        }

        return count;
    }
};