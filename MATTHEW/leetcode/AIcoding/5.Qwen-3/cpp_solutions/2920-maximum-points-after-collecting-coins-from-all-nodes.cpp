#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int collectTheCoins(vector<int>& coins, vector<vector<int>>& edges) {
        int n = coins.size();
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> degree(n);
        for (int i = 0; i < n; ++i) {
            degree[i] = graph[i].size();
        }

        vector<bool> isLeaf(n, false);
        for (int i = 0; i < n; ++i) {
            if (degree[i] == 1) {
                isLeaf[i] = true;
            }
        }

        vector<int> parent(n, -1);
        vector<int> depth(n, 0);

        for (int i = 0; i < n; ++i) {
            if (isLeaf[i]) {
                queue<int> q;
                q.push(i);
                while (!q.empty()) {
                    int u = q.front();
                    q.pop();
                    for (int v : graph[u]) {
                        if (parent[u] != v) {
                            parent[v] = u;
                            depth[v] = depth[u] + 1;
                            if (degree[v] > 1) {
                                --degree[v];
                                if (degree[v] == 1) {
                                    isLeaf[v] = true;
                                    q.push(v);
                                }
                            }
                        }
                    }
                }
            }
        }

        int maxDepth = *max_element(depth.begin(), depth.end());
        return max(0, maxDepth - 1);
    }
};