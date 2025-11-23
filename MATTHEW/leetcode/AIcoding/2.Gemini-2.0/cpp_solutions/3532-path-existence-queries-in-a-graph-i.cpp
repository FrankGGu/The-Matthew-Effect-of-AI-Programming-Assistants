#include <vector>

using namespace std;

class Solution {
public:
    vector<bool> pathQueries(int n, vector<vector<int>>& edges, vector<vector<int>>& queries) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<bool> result;
        for (auto& query : queries) {
            int start = query[0];
            int end = query[1];
            vector<bool> visited(n, false);
            bool found = false;
            vector<int> q;
            q.push_back(start);
            visited[start] = true;

            int head = 0;
            while (head < q.size()) {
                int u = q[head++];
                if (u == end) {
                    found = true;
                    break;
                }
                for (int v : adj[u]) {
                    if (!visited[v]) {
                        visited[v] = true;
                        q.push_back(v);
                    }
                }
            }
            result.push_back(found);
        }

        return result;
    }
};