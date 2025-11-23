class Solution {
public:
    vector<bool> distanceLimitedPathsExist(int n, vector<vector<int>>& edgeList, vector<vector<int>>& queries) {
        vector<bool> result(queries.size());
        vector<int> parent(n), rank(n, 0);

        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        auto find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        auto union_sets = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                if (rank[rootX] > rank[rootY]) {
                    parent[rootY] = rootX;
                } else if (rank[rootX] < rank[rootY]) {
                    parent[rootX] = rootY;
                } else {
                    parent[rootY] = rootX;
                    ++rank[rootX];
                }
            }
        };

        sort(edgeList.begin(), edgeList.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });

        vector<tuple<int, int, int, int>> queryWithIndex;
        for (int i = 0; i < queries.size(); ++i) {
            queryWithIndex.emplace_back(queries[i][2], queries[i][0], queries[i][1], i);
        }
        sort(queryWithIndex.begin(), queryWithIndex.end());

        int edgeIndex = 0;
        for (const auto& [limit, u, v, idx] : queryWithIndex) {
            while (edgeIndex < edgeList.size() && edgeList[edgeIndex][2] < limit) {
                union_sets(edgeList[edgeIndex][0], edgeList[edgeIndex][1]);
                ++edgeIndex;
            }
            result[idx] = find(u) == find(v);
        }

        return result;
    }
};