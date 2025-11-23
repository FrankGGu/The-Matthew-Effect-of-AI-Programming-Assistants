#include <vector>
#include <numeric> 
#include <algorithm> 

class DSU {
public:
    std::vector<int> parent;
    std::vector<int> sz; 

    DSU(int n) {
        parent.resize(n + 1);
        std::iota(parent.begin(), parent.end(), 0); 
        sz.assign(n + 1, 1); 
    }

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]); 
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            if (sz[root_i] < sz[root_j])
                std::swap(root_i, root_j);
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
        }
    }
};

class Solution {
public:
    std::vector<bool> areConnected(int n, int threshold, std::vector<std::vector<int>>& queries) {
        DSU dsu(n);

        for (int k = threshold + 1; k <= n; ++k) {
            for (int multiple = 2 * k; multiple <= n; multiple += k) {
                dsu.unite(k, multiple);
            }
        }

        std::vector<bool> result;
        result.reserve(queries.size()); 
        for (const auto& query : queries) {
            int u = query[0];
            int v = query[1];
            result.push_back(dsu.find(u) == dsu.find(v));
        }

        return result;
    }
};