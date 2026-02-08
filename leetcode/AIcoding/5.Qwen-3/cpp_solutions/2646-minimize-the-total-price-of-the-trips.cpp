#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimizePrice(vector<vector<int>>& trips, vector<int>& price) {
        int n = price.size();
        vector<vector<int>> graph(n);
        for (auto& trip : trips) {
            int u = trip[0], v = trip[1];
            graph[u].push_back(v);
            graph[v].push_back(u);
        }

        vector<int> parent(n, -1);
        vector<bool> visited(n, false);

        function<void(int)> dfsParent = [&](int node) {
            visited[node] = true;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    parent[neighbor] = node;
                    dfsParent(neighbor);
                }
            }
        };

        dfsParent(0);

        vector<int> depth(n, 0);
        function<void(int, int)> dfsDepth = [&](int node, int d) {
            depth[node] = d;
            for (int neighbor : graph[node]) {
                if (neighbor != parent[node]) {
                    dfsDepth(neighbor, d + 1);
                }
            }
        };

        dfsDepth(0, 0);

        vector<int> up(n, 0);
        vector<vector<int>> upTable(n, vector<int>(20, 0));

        function<void(int)> dfsUp = [&](int node) {
            upTable[node][0] = parent[node];
            for (int i = 1; i < 20; ++i) {
                upTable[node][i] = upTable[upTable[node][i - 1]][i - 1];
            }
            for (int neighbor : graph[node]) {
                if (neighbor != parent[node]) {
                    dfsUp(neighbor);
                }
            }
        };

        dfsUp(0);

        function<int(int, int)> lca = [&](int u, int v) {
            if (depth[u] < depth[v]) swap(u, v);
            for (int i = 19; i >= 0; --i) {
                if (depth[u] - (1 << i) >= depth[v]) {
                    u = upTable[u][i];
                }
            }
            if (u == v) return u;
            for (int i = 19; i >= 0; --i) {
                if (upTable[u][i] != upTable[v][i]) {
                    u = upTable[u][i];
                    v = upTable[v][i];
                }
            }
            return parent[u];
        };

        vector<int> totalPrice(n, 0);
        for (auto& trip : trips) {
            int u = trip[0], v = trip[1];
            int ancestor = lca(u, v);
            totalPrice[u]++;
            totalPrice[v]++;
            totalPrice[ancestor]--;
        }

        function<void(int)> dfsTotal = [&](int node) {
            for (int neighbor : graph[node]) {
                if (neighbor != parent[node]) {
                    dfsTotal(neighbor);
                    totalPrice[node] += totalPrice[neighbor];
                }
            }
        };

        dfsTotal(0);

        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (totalPrice[i] > 0) {
                result += price[i] * totalPrice[i];
            }
        }

        return result;
    }
};