#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> countSubgraphsForEachMaxDistance(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> result(2);
        for (int mask = 1; mask < (1 << n); ++mask) {
            vector<bool> visited(n, false);
            int maxDist = 0;
            int nodes = 0;
            vector<int> queue;
            for (int i = 0; i < n; ++i) {
                if ((mask >> i) & 1) {
                    queue.push_back(i);
                    visited[i] = true;
                    nodes++;
                }
            }

            if (nodes == 0) continue;

            int dist = 0;
            while (!queue.empty()) {
                int size = queue.size();
                for (int i = 0; i < size; ++i) {
                    int u = queue[i];
                    for (int v : adj[u]) {
                        if (!visited[v]) {
                            visited[v] = true;
                            queue.push_back(v);
                        }
                    }
                }
                if (queue.size() > size) {
                    dist++;
                }
                queue.erase(queue.begin(), queue.begin() + size);
            }

            if (dist > 0) {
                result[dist]++;
            }
        }

        return result;
    }
};