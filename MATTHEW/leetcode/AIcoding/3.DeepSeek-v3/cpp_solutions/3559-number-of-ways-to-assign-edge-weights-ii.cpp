#include <vector>
#include <unordered_map>
#include <algorithm>
using namespace std;

class UnionFind {
private:
    vector<int> parent;
    vector<int> rank;
public:
    UnionFind(int n) {
        parent.resize(n);
        rank.resize(n, 0);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unite(int x, int y) {
        int px = find(x);
        int py = find(y);
        if (px == py) return;
        if (rank[px] < rank[py]) {
            parent[px] = py;
        } else {
            parent[py] = px;
            if (rank[px] == rank[py]) {
                rank[px]++;
            }
        }
    }
};

class Solution {
public:
    int numberOfGoodPaths(vector<int>& vals, vector<vector<int>>& edges) {
        int n = vals.size();
        vector<vector<int>> adj(n);
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].push_back(v);
            adj[v].push_back(u);
        }

        map<int, vector<int>> valueToNodes;
        for (int i = 0; i < n; ++i) {
            valueToNodes[vals[i]].push_back(i);
        }

        UnionFind uf(n);
        int res = 0;

        for (const auto& [val, nodes] : valueToNodes) {
            for (int u : nodes) {
                for (int v : adj[u]) {
                    if (vals[v] <= val) {
                        uf.unite(u, v);
                    }
                }
            }

            unordered_map<int, int> groupCount;
            for (int u : nodes) {
                groupCount[uf.find(u)]++;
            }

            for (const auto& [_, cnt] : groupCount) {
                res += cnt * (cnt + 1) / 2;
            }
        }

        return res;
    }
};