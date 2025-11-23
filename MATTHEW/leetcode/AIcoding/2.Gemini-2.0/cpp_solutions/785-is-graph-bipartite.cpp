#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool isBipartite(vector<vector<int>>& graph) {
        int n = graph.size();
        vector<int> colors(n, 0);

        for (int startNode = 0; startNode < n; ++startNode) {
            if (colors[startNode] == 0) {
                queue<int> q;
                q.push(startNode);
                colors[startNode] = 1;

                while (!q.empty()) {
                    int u = q.front();
                    q.pop();

                    for (int v : graph[u]) {
                        if (colors[v] == 0) {
                            colors[v] = -colors[u];
                            q.push(v);
                        } else if (colors[v] == colors[u]) {
                            return false;
                        }
                    }
                }
            }
        }

        return true;
    }
};