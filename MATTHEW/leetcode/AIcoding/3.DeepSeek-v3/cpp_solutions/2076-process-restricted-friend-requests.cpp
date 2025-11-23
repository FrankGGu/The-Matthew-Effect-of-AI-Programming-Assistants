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

    bool unite(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX == rootY) {
            return false;
        }
        if (rank[rootX] < rank[rootY]) {
            parent[rootX] = rootY;
        } else {
            parent[rootY] = rootX;
            if (rank[rootX] == rank[rootY]) {
                rank[rootX]++;
            }
        }
        return true;
    }
};

class Solution {
public:
    vector<bool> friendRequests(int n, vector<vector<int>>& restrictions, vector<vector<int>>& requests) {
        UnionFind uf(n);
        vector<bool> res;
        for (const auto& req : requests) {
            int u = req[0], v = req[1];
            int rootU = uf.find(u);
            int rootV = uf.find(v);
            bool valid = true;
            for (const auto& res : restrictions) {
                int a = res[0], b = res[1];
                int rootA = uf.find(a);
                int rootB = uf.find(b);
                if ((rootA == rootU && rootB == rootV) || (rootA == rootV && rootB == rootU)) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                uf.unite(u, v);
                res.push_back(true);
            } else {
                res.push_back(false);
            }
        }
        return res;
    }
};