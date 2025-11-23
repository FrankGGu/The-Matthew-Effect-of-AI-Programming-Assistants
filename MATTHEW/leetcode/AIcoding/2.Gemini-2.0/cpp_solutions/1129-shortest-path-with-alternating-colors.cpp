#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> shortestAlternatingPaths(int n, vector<vector<int>>& redEdges, vector<vector<int>>& blueEdges) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : redEdges) {
            adj[edge[0]].push_back({edge[1], 0}); 
        }
        for (auto& edge : blueEdges) {
            adj[edge[0]].push_back({edge[1], 1}); 
        }

        vector<int> dist(n, -1);
        vector<vector<bool>> visited(n, vector<bool>(2, false));

        queue<pair<int, int>> q; 
        q.push({0, -1}); 
        dist[0] = 0;
        visited[0][0] = true;
        visited[0][1] = true;

        int steps = 0;
        while (!q.empty()) {
            int size = q.size();
            steps++;
            for (int i = 0; i < size; ++i) {
                int u = q.front().first;
                int prevColor = q.front().second;
                q.pop();

                for (auto& edge : adj[u]) {
                    int v = edge.first;
                    int color = edge.second;

                    if (color != prevColor && !visited[v][color]) {
                        if (dist[v] == -1) {
                            dist[v] = steps;
                        }
                        visited[v][color] = true;
                        q.push({v, color});
                    }
                }
            }
        }

        return dist;
    }
};