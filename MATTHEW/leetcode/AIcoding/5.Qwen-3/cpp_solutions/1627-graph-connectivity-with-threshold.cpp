#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
private:
    vector<int> parent;

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
            parent[rootY] = rootX;
        }
    }

public:
    vector<bool> areConnected(int n, int threshold, vector<vector<int>>& queries) {
        parent.resize(n);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        for (int i = threshold + 1; i <= n; ++i) {
            for (int j = 2 * i; j <= n; j += i) {
                unite(i - 1, j - 1);
            }
        }

        vector<bool> result;
        for (const auto& q : queries) {
            int u = q[0] - 1;
            int v = q[1] - 1;
            result.push_back(find(u) == find(v));
        }

        return result;
    }
};