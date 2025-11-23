#include <vector>
#include <queue>
#include <cmath>

using namespace std;

class Solution {
public:
    int minCostConnectPoints(vector<vector<int>>& points) {
        int n = points.size();
        vector<bool> inMST(n, false);
        vector<int> minEdge(n, INT_MAX);
        minEdge[0] = 0;

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.push({0, 0});
        int totalCost = 0;

        while (!pq.empty()) {
            auto [cost, u] = pq.top();
            pq.pop();

            if (inMST[u]) continue;
            inMST[u] = true;
            totalCost += cost;

            for (int v = 0; v < n; v++) {
                if (!inMST[v]) {
                    int edgeCost = abs(points[u][0] - points[v][0]) + abs(points[u][1] - points[v][1]);
                    if (edgeCost < minEdge[v]) {
                        minEdge[v] = edgeCost;
                        pq.push({edgeCost, v});
                    }
                }
            }
        }

        return totalCost;
    }
};