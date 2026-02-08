#include <vector>

using namespace std;

class DSU {
public:
    vector<int> parent;
    vector<int> rank;

    DSU(int n) {
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
        }
    }
};

class Solution {
public:
    vector<bool> friendRequests(int n, vector<vector<int>>& restrictions, vector<vector<int>>& requests) {
        vector<bool> ans;
        DSU dsu(n);

        for (auto& request : requests) {
            int u = request[0];
            int v = request[1];
            int pu = dsu.find(u);
            int pv = dsu.find(v);

            bool canUnite = true;
            for (auto& restriction : restrictions) {
                int x = restriction[0];
                int y = restriction[1];
                int px = dsu.find(x);
                int py = dsu.find(y);

                if ((pu == px && pv == py) || (pu == py && pv == px)) {
                    canUnite = false;
                    break;
                }
            }

            if (canUnite) {
                dsu.unite(u, v);
                ans.push_back(true);
            } else {
                ans.push_back(false);
            }
        }

        return ans;
    }
};