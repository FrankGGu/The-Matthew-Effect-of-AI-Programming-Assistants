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
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else {
                parent[rootY] = rootX;
                if (rank[rootX] == rank[rootY]) {
                    rank[rootX]++;
                }
            }
        }
    }
    bool connected(int x, int y) {
        return find(x) == find(y);
    }
};

class Solution {
public:
    vector<bool> distanceLimitedPathsExist(int n, vector<vector<int>>& edgeList, vector<vector<int>>& queries) {
        vector<tuple<int, int, int, int>> q;
        for (int i = 0; i < queries.size(); ++i) {
            q.emplace_back(queries[i][2], queries[i][0], queries[i][1], i);
        }
        sort(q.begin(), q.end());
        sort(edgeList.begin(), edgeList.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });
        UnionFind uf(n);
        vector<bool> res(queries.size());
        int edgeIdx = 0;
        for (auto& [limit, u, v, idx] : q) {
            while (edgeIdx < edgeList.size() && edgeList[edgeIdx][2] < limit) {
                uf.unite(edgeList[edgeIdx][0], edgeList[edgeIdx][1]);
                edgeIdx++;
            }
            res[idx] = uf.connected(u, v);
        }
        return res;
    }
};