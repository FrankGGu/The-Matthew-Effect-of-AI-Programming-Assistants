#include <vector>
#include <unordered_map>
#include <queue>
using namespace std;

class Solution {
public:
    int maximumNodes(int n, vector<vector<int>>& edges, vector<int>& target) {
        unordered_map<int, vector<int>> graph;
        vector<int> degree(n + 1, 0);
        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1];
            graph[u].push_back(v);
            graph[v].push_back(u);
            degree[u]++;
            degree[v]++;
        }

        queue<int> q;
        for (int i = 1; i <= n; ++i) {
            if (degree[i] == 1) {
                q.push(i);
            }
        }

        vector<bool> removed(n + 1, false);
        int res = 0;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            if (removed[u]) continue;
            if (target[u - 1] == 1) {
                res++;
                removed[u] = true;
                continue;
            }
            for (int v : graph[u]) {
                if (!removed[v]) {
                    target[v - 1] += target[u - 1];
                    degree[v]--;
                    if (degree[v] == 1) {
                        q.push(v);
                    }
                }
            }
            removed[u] = true;
        }
        return res;
    }
};