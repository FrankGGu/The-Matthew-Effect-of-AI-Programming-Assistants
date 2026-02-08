#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<bool> distanceLimitedPathsExist(vector<int>& n, vector<vector<int>>& queries) {
        int q = queries.size();
        vector<bool> result(q, false);
        vector<int> parent(n.size());

        for (int i = 0; i < n.size(); ++i) {
            parent[i] = i;
        }

        auto find = [&](int x) {
            return parent[x] == x ? x : parent[x] = find(parent[x]);
        };

        auto unionSet = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
            }
        };

        vector<pair<int, int>> edges;
        for (int i = 0; i < n.size() - 1; ++i) {
            edges.push_back({n[i], i});
        }
        sort(edges.begin(), edges.end());

        for (int i = 0; i < q; ++i) {
            queries[i].push_back(i);
        }

        sort(queries.begin(), queries.end(), [&](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });

        int edgeIndex = 0;
        for (int i = 0; i < q; ++i) {
            int u = queries[i][0];
            int v = queries[i][1];
            int limit = queries[i][2];
            int idx = queries[i][3];

            while (edgeIndex < edges.size() && edges[edgeIndex].first < limit) {
                int uEdge = edges[edgeIndex].second;
                int vEdge = uEdge + 1;
                unionSet(uEdge, vEdge);
                ++edgeIndex;
            }

            if (find(u) == find(v)) {
                result[idx] = true;
            }
        }

        return result;
    }
};