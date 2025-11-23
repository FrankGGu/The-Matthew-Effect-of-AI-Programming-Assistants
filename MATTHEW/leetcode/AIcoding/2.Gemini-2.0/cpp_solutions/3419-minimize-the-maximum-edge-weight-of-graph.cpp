#include <vector>
#include <algorithm>

using namespace std;

class DSU {
public:
    DSU(int n) : parent(n), rank(n, 0) {
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

    bool unite(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
            return true;
        }
        return false;
    }

private:
    vector<int> parent;
    vector<int> rank;
};

class Solution {
public:
    int minimizeMaximumEdgeWeight(int n, vector<vector<int>>& edges, int k) {
        sort(edges.begin(), edges.end(), [](const auto& a, const auto& b) {
            return a[2] < b[2];
        });

        int left = 0, right = 1e9;
        int ans = -1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            DSU dsu(n);
            int components = n;
            int num_edges = 0;
            for (const auto& edge : edges) {
                if (edge[2] <= mid) {
                    if (dsu.unite(edge[0], edge[1])) {
                        components--;
                        num_edges++;
                    }
                }
            }

            if (components <= k) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
};