#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> findCriticalAndPseudoCriticalEdges(int n, vector<vector<int>>& edges) {
        int m = edges.size();
        for (int i = 0; i < m; ++i) {
            edges[i].push_back(i);
        }
        sort(edges.begin(), edges.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });

        auto kruskal = [&](int exclude, int include) {
            vector<int> parent(n);
            for (int i = 0; i < n; ++i) {
                parent[i] = i;
            }
            function<int(int)> find = [&](int x) {
                if (parent[x] != x) {
                    parent[x] = find(parent[x]);
                }
                return parent[x];
            };
            auto unite = [&](int x, int y) {
                int rootX = find(x);
                int rootY = find(y);
                if (rootX != rootY) {
                    parent[rootX] = rootY;
                    return true;
                }
                return false;
            };

            int mstWeight = 0;
            int edgeCount = 0;

            if (include != -1) {
                unite(edges[include][0], edges[include][1]);
                mstWeight += edges[include][2];
                edgeCount++;
            }

            for (int i = 0; i < m; ++i) {
                if (i == exclude) continue;
                int u = edges[i][0];
                int v = edges[i][1];
                int w = edges[i][2];
                if (unite(u, v)) {
                    mstWeight += w;
                    edgeCount++;
                }
            }

            int root = find(0);
            for (int i = 1; i < n; ++i) {
                if (find(i) != root) {
                    return INT_MAX;
                }
            }

            if (edgeCount != n - 1) return INT_MAX;
            return mstWeight;
        };

        int minWeight = kruskal(-1, -1);

        vector<int> critical, pseudoCritical;
        for (int i = 0; i < m; ++i) {
            if (kruskal(i, -1) > minWeight) {
                critical.push_back(edges[i][3]);
            } else if (kruskal(-1, i) == minWeight) {
                pseudoCritical.push_back(edges[i][3]);
            }
        }

        vector<vector<int>> result;
        result.push_back(critical);
        result.push_back(pseudoCritical);
        return result;
    }
};