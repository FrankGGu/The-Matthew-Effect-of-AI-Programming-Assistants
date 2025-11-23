#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int countWays(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (const auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<int> degree(n);
        for (int i = 0; i < n; ++i) {
            degree[i] = adj[i].size();
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (degree[i] == 1) {
                q.push(i);
            }
        }

        long long res = 1;
        int remaining = n;
        while (remaining > 2) {
            int sz = q.size();
            remaining -= sz;
            for (int i = 0; i < sz; ++i) {
                int u = q.front();
                q.pop();
                for (int v : adj[u]) {
                    if (--degree[v] == 1) {
                        q.push(v);
                    }
                }
            }
            res = res * (sz + 1) % 1000000007;
        }

        return res;
    }
};