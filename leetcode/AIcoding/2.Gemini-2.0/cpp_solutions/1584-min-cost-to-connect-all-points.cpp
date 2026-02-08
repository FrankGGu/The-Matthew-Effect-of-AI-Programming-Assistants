#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCostConnectPoints(vector<vector<int>>& points) {
        int n = points.size();
        vector<pair<int, pair<int, int>>> edges;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1]);
                edges.push_back({dist, {i, j}});
            }
        }

        sort(edges.begin(), edges.end());

        vector<int> parent(n);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            if (parent[x] == x) {
                return x;
            }
            return parent[x] = find(parent[x]);
        };

        auto unite = [&](int x, int y) {
            x = find(x);
            y = find(y);
            if (x != y) {
                parent[x] = y;
                return true;
            }
            return false;
        };

        int cost = 0;
        int count = 0;
        for (auto& edge : edges) {
            int w = edge.first;
            int u = edge.second.first;
            int v = edge.second.second;
            if (unite(u, v)) {
                cost += w;
                count++;
            }
            if (count == n - 1) {
                break;
            }
        }

        return cost;
    }
};