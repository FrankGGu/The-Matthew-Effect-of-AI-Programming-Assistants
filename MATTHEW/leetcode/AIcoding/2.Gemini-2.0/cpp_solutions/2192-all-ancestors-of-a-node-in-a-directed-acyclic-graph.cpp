#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> getAncestors(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        vector<int> inDegree(n, 0);

        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            inDegree[edge[1]]++;
        }

        vector<vector<int>> ancestors(n);
        for (int startNode = 0; startNode < n; ++startNode) {
            vector<int> currentAncestors;
            vector<int> visited(n, 0);
            queue<int> q;
            vector<int> tempInDegree = inDegree;

            q.push(startNode);

            while (!q.empty()) {
                int u = q.front();
                q.pop();

                for (int v = 0; v < n; ++v) {
                    if (find(adj[v].begin(), adj[v].end(), u) != adj[v].end() && v != startNode) {
                        if(visited[v] == 0){
                            currentAncestors.push_back(v);
                            visited[v] = 1;
                        }

                    }
                }
            }

            sort(currentAncestors.begin(), currentAncestors.end());
            ancestors[startNode] = currentAncestors;
        }

        return ancestors;
    }
};