#include <vector>
#include <numeric> // For std::iota
#include <algorithm> // For std::swap

class UnionFind {
public:
    std::vector<int> parent;
    std::vector<int> sz; // Using size for union by size optimization

    UnionFind(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0); // Each element is its own parent
        sz.assign(n, 1); // Each set has size 1 initially
    }

    int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]); // Path compression
    }

    // Returns true if a union happened, false if they were already in the same set
    bool unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);

        if (root_i != root_j) {
            // Union by size
            if (sz[root_i] < sz[root_j]) {
                std::swap(root_i, root_j);
            }
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
            return true;
        }
        return false;
    }
};

class Solution {
public:
    std::vector<bool> friendRequests(int n, std::vector<std::vector<int>>& restrictions, std::vector<std::vector<int>>& requests) {
        UnionFind uf(n);
        std::vector<bool> ans;

        for (const auto& request : requests) {
            int u = request[0];
            int v = request[1];

            int rootU = uf.find(u);
            int rootV = uf.find(v);

            if (rootU == rootV) {
                ans.push_back(true);
                continue;
            }

            bool canGrant = true;
            for (const auto& restriction : restrictions) {
                int r1 = restriction[0];
                int r2 = restriction[1];

                int rootR1 = uf.find(r1);
                int rootR2 = uf.find(r2);

                if ((rootR1 == rootU && rootR2 == rootV) || (rootR1 == rootV && rootR2 == rootU)) {
                    canGrant = false;
                    break;
                }
            }

            if (canGrant) {
                uf.unite(u, v);
                ans.push_back(true);
            } else {
                ans.push_back(false);
            }
        }

        return ans;
    }
};