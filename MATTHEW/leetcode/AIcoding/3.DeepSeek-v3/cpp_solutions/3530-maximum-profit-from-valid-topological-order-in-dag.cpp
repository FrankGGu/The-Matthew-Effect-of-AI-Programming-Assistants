#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int maxProfit(int n, vector<vector<int>>& edges, vector<int>& profit) {
        vector<vector<int>> graph(n);
        vector<int> inDegree(n, 0);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1];
            graph[u].push_back(v);
            inDegree[v]++;
        }

        queue<int> q;
        vector<int> maxProfit(n, INT_MIN);
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
                maxProfit[i] = profit[i];
            }
        }

        int res = INT_MIN;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            res = max(res, maxProfit[u]);

            for (int v : graph[u]) {
                if (maxProfit[v] < maxProfit[u] + profit[v]) {
                    maxProfit[v] = maxProfit[u] + profit[v];
                }
                if (--inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return res;
    }
};