#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<bool> distanceLimitedPathsExist(int n, std::vector<std::vector<int>>& edgeList, std::vector<std::vector<int>>& queries) {
        struct DSU {
            std::vector<int> parent;
            DSU(int size) {
                parent.resize(size);
                std::iota(parent.begin(), parent.end(), 0);
            }
            int find(int x) {
                if (parent[x] == x) {
                    return x;
                }
                return parent[x] = find(parent[x]);
            }
            void unite(int x, int y) {
                int rootX = find(x);
                int rootY = find(y);
                if (rootX != rootY) {
                    parent[rootX] = rootY;
                }
            }
        };

        std::vector<std::vector<int>> indexedQueries;
        for (int i = 0; i < queries.size(); ++i) {
            indexedQueries.push_back({queries[i][0], queries[i][1], queries[i][2], i});
        }

        std::sort(edgeList.begin(), edgeList.end(), [](const auto& a, const auto& b) {
            return a[2] < b[2];
        });

        std::sort(indexedQueries.begin(), indexedQueries.end(), [](const auto& a, const auto& b) {
            return a[2] < b[2];
        });

        DSU dsu(n);
        std::vector<bool> result(queries.size());
        int edgeIndex = 0;

        for (const auto& query : indexedQueries) {
            int p = query[0];
            int q = query[1];
            int limit = query[2];
            int originalIndex = query[3];

            while (edgeIndex < edgeList.size() && edgeList[edgeIndex][2] < limit) {
                dsu.unite(edgeList[edgeIndex][0], edgeList[edgeIndex][1]);
                edgeIndex++;
            }

            result[originalIndex] = (dsu.find(p) == dsu.find(q));
        }

        return result;
    }
};