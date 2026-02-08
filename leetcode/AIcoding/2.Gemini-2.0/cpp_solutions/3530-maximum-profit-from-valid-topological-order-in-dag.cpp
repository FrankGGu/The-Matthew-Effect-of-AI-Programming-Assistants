#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    long long maximumProfit(int n, vector<vector<int>>& edges, vector<int>& amount) {
        vector<vector<int>> adj(n);
        vector<int> indegree(n, 0);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            indegree[edge[1]]++;
        }

        queue<int> q;
        vector<long long> profit(n, 0);
        vector<bool> visited(n, false);

        for (int i = 0; i < n; i++) {
            if (indegree[i] == 0) {
                q.push(i);
                profit[i] = amount[i];
                visited[i] = true;
            }
        }

        long long totalProfit = 0;
        int count = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            totalProfit += profit[u];
            count++;

            for (int v : adj[u]) {
                indegree[v]--;
                if (amount[v] > 0) {
                    profit[v] = max(profit[v], profit[u] + amount[v]);
                } else {
                    profit[v] = max(profit[v], profit[u] + amount[v]);
                }
                if (indegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        if (count != n) {
            return -1;
        }

        return totalProfit;
    }
};