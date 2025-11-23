#include <vector>
#include <queue>
#include <numeric>

using namespace std;

class Solution {
public:
    long long maximumProfit(vector<vector<int>>& edges, vector<int>& profit) {
        int n = profit.size();
        vector<vector<int>> graph(n);
        vector<int> inDegree(n, 0);
        vector<long long> dp(n, 0);

        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            inDegree[edge[1]]++;
        }

        queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                dp[i] = profit[i];
                q.push(i);
            }
        }

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            for (int neighbor : graph[node]) {
                dp[neighbor] = max(dp[neighbor], dp[node] + profit[neighbor]);
                if (--inDegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        return *max_element(dp.begin(), dp.end());
    }
};