class Solution {
public:
    vector<bool> areConnected(int n, int threshold, vector<vector<int>>& queries) {
        vector<int> parent(n + 1);
        iota(parent.begin(), parent.end(), 0);

        auto find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        auto unionSets = [&](int x, int y) {
            parent[find(x)] = find(y);
        };

        for (int i = threshold + 1; i <= n; ++i) {
            if (i % 2 == 0) {
                for (int j = i; j <= n; j += i) {
                    unionSets(i, j);
                }
            }
        }

        vector<bool> result;
        for (const auto& query : queries) {
            result.push_back(find(query[0]) == find(query[1]));
        }

        return result;
    }
};