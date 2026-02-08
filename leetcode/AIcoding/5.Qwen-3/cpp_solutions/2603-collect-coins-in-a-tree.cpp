#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int collectCoins(vector<vector<int>>& tree, int k) {
        int n = tree.size();
        vector<int> degree(n, 0);
        vector<int> dist(n, 0);
        vector<bool> visited(n, false);

        for (int i = 0; i < n; ++i) {
            degree[i] = tree[i].size();
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (degree[i] == 1) {
                q.push(i);
            }
        }

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            visited[u] = true;
            for (int v : tree[u]) {
                if (!visited[v]) {
                    degree[v]--;
                    dist[v] = dist[u] + 1;
                    if (degree[v] == 1) {
                        q.push(v);
                    }
                }
            }
        }

        vector<int> depths;
        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                depths.push_back(dist[i]);
            }
        }

        sort(depths.begin(), depths.end());
        int res = 0;
        for (int i = 0; i < min(k, (int)depths.size()); ++i) {
            res += depths[depths.size() - 1 - i];
        }

        return res;
    }
};