#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int magnificentSets(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> color(n, -1);
        vector<int> dist(n, 0);

        function<bool(int, int)> bfs = [&](int start, int& maxDepth) {
            queue<int> q;
            q.push(start);
            fill(dist.begin(), dist.end(), -1);
            dist[start] = 0;
            maxDepth = 0;
            while (!q.empty()) {
                int u = q.front();
                q.pop();
                for (int v : graph[u]) {
                    if (dist[v] == -1) {
                        dist[v] = dist[u] + 1;
                        maxDepth = max(maxDepth, dist[v]);
                        q.push(v);
                    }
                }
            }
            return true;
        };

        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (color[i] == -1) {
                queue<int> q;
                q.push(i);
                color[i] = 0;
                while (!q.empty()) {
                    int u = q.front();
                    q.pop();
                    for (int v : graph[u]) {
                        if (color[v] == -1) {
                            color[v] = color[u] ^ 1;
                            q.push(v);
                        }
                    }
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            if (color[i] == 0) {
                int maxDepth = 0;
                bfs(i, maxDepth);
                result += maxDepth + 1;
            }
        }

        return result;
    }
};