#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> countPairs(int n, vector<vector<int>>& edges, vector<int>& queries) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        vector<int> result;
        for (int q : queries) {
            vector<int> dist(n, 0);
            vector<bool> visited(n, false);
            int count = 0;
            for (int i = 0; i < n; ++i) {
                if (!visited[i]) {
                    vector<int> stack;
                    stack.push_back(i);
                    visited[i] = true;
                    dist[i] = 0;
                    while (!stack.empty()) {
                        int node = stack.back();
                        stack.pop_back();
                        for (auto& [neighbor, weight] : adj[node]) {
                            if (!visited[neighbor]) {
                                visited[neighbor] = true;
                                dist[neighbor] = dist[node] + weight;
                                stack.push_back(neighbor);
                            }
                        }
                    }
                }
            }

            sort(dist.begin(), dist.end());
            int total = 0;
            for (int i = 0; i < n; ++i) {
                if (dist[i] >= q) {
                    int j = upper_bound(dist.begin(), dist.end(), q - 1 - dist[i]) - dist.begin();
                    total += (n - j);
                }
            }
            result.push_back(total / 2);
        }
        return result;
    }
};