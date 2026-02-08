#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
private:
    int find(int u, vector<int>& parent) {
        if (parent[u] != u)
            parent[u] = find(parent[u], parent);
        return parent[u];
    }

    bool unionSet(int u, int v, vector<int>& parent, vector<int>& rank) {
        int rootU = find(u, parent);
        int rootV = find(v, parent);
        if (rootU == rootV)
            return false;
        if (rank[rootU] > rank[rootV])
            parent[rootV] = rootU;
        else {
            parent[rootU] = rootV;
            if (rank[rootU] == rank[rootV])
                rank[rootV]++;
        }
        return true;
    }

    int kruskal(int n, vector<vector<int>>& edges, int excludeEdge = -1, int includeEdge = -1) {
        vector<int> parent(n);
        vector<int> rank(n, 0);
        for (int i = 0; i < n; ++i)
            parent[i] = i;

        int totalWeight = 0;
        int edgeCount = 0;

        if (includeEdge != -1) {
            int u = edges[includeEdge][0];
            int v = edges[includeEdge][1];
            int w = edges[includeEdge][2];
            if (unionSet(u, v, parent, rank)) {
                totalWeight += w;
                edgeCount++;
            }
        }

        for (int i = 0; i < edges.size(); ++i) {
            if (i == excludeEdge)
                continue;
            int u = edges[i][0];
            int v = edges[i][1];
            int w = edges[i][2];
            if (unionSet(u, v, parent, rank)) {
                totalWeight += w;
                edgeCount++;
            }
        }

        if (edgeCount != n - 1)
            return -1;
        return totalWeight;
    }

public:
    vector<vector<int>> findCriticalMakeSpanningTree(int n, vector<vector<int>>& edges) {
        int m = edges.size();
        vector<int> critical;
        vector<int> pseudoCritical;

        for (int i = 0; i < m; ++i) {
            int weightWithout = kruskal(n, edges, i);
            if (weightWithout == -1 || weightWithout > kruskal(n, edges))
                critical.push_back(i);
        }

        for (int i = 0; i < m; ++i) {
            int weightWith = kruskal(n, edges, -1, i);
            if (weightWith != -1 && weightWith == kruskal(n, edges))
                pseudoCritical.push_back(i);
        }

        vector<vector<int>> result;
        result.push_back(critical);
        result.push_back(pseudoCritical);
        return result;
    }
};