#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> shortestDistanceAfterRoadQueries(int n, vector<vector<int>>& queries) {
        vector<vector<int>> graph(n);
        for (int i = 0; i < n - 1; ++i) {
            graph[i].push_back(i + 1);
        }

        vector<int> result;
        for (const auto& query : queries) {
            int u = query[0];
            int v = query[1];
            graph[u].push_back(v);

            vector<int> dist(n, -1);
            queue<int> q;
            dist[0] = 0;
            q.push(0);

            while (!q.empty()) {
                int node = q.front();
                q.pop();
                for (int neighbor : graph[node]) {
                    if (dist[neighbor] == -1) {
                        dist[neighbor] = dist[node] + 1;
                        q.push(neighbor);
                    }
                }
            }

            result.push_back(dist[n - 1]);
        }

        return result;
    }
};