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

    int find(int u) {
        if (parent[u] != u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    void unite(int u, int v) {
        int pu = find(u);
        int pv = find(v);
        if (pu != pv) {
            if (rank[pu] < rank[pv]) {
                parent[pu] = pv;
            } else if (rank[pu] > rank[pv]) {
                parent[pv] = pu;
            } else {
                parent[pv] = pu;
                rank[pu]++;
            }
        }
    }

    bool connected(int u, int v) {
        return find(u) == find(v);
    }
};

class Solution {
public:
    vector<bool> distanceLimitedPathsExist(int n, vector<vector<int>>& edgeList, vector<vector<int>>& queries) {
        vector<tuple<int, int, int, int>> indexedQueries;
        for (int i = 0; i < queries.size(); ++i) {
            indexedQueries.emplace_back(queries[i][2], queries[i][0], queries[i][1], i);
        }
        sort(indexedQueries.begin(), indexedQueries.end());
        sort(edgeList.begin(), edgeList.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });

        UnionFind uf(n);
        vector<bool> result(queries.size());
        int edgeIndex = 0;
        for (const auto& [limit, u, v, idx] : indexedQueries) {
            while (edgeIndex < edgeList.size() && edgeList[edgeIndex][2] < limit) {
                uf.unite(edgeList[edgeIndex][0], edgeList[edgeIndex][1]);
                edgeIndex++;
            }
            result[idx] = uf.connected(u, v);
        }
        return result;
    }
};