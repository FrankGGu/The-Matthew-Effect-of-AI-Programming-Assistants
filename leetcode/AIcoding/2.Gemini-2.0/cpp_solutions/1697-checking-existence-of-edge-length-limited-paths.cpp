#include <vector>
#include <algorithm>

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
        if (x != parent[x]) {
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
    vector<bool> distanceLimitedPathsExist(int n, vector<vector<int>>& edgeList, vector<vector<int>>& queries) {
        int q = queries.size();
        vector<bool> ans(q);
        vector<int> queryIndices(q);
        for (int i = 0; i < q; ++i) {
            queryIndices[i] = i;
        }

        sort(queryIndices.begin(), queryIndices.end(), [&](int a, int b) {
            return queries[a][2] < queries[b][2];
        });

        sort(edgeList.begin(), edgeList.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });

        DSU dsu(n);
        int edgeIndex = 0;

        for (int i : queryIndices) {
            int p = queries[i][0];
            int q = queries[i][1];
            int limit = queries[i][2];

            while (edgeIndex < edgeList.size() && edgeList[edgeIndex][2] < limit) {
                dsu.unite(edgeList[edgeIndex][0], edgeList[edgeIndex][1]);
                edgeIndex++;
            }

            ans[i] = (dsu.find(p) == dsu.find(q));
        }

        return ans;
    }
};