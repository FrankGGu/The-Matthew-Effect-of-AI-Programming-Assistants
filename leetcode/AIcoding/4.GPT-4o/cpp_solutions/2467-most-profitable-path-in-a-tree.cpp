#include <vector>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    int mostProfitablePath(vector<vector<int>>& edges, int bob, vector<int>& amount) {
        int n = amount.size();
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> dist(n, -1);
        queue<int> q;
        q.push(bob);
        dist[bob] = 0;

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            for (int neighbor : graph[node]) {
                if (dist[neighbor] == -1) {
                    dist[neighbor] = dist[node] + 1;
                    q.push(neighbor);
                }
            }
        }

        int maxProfit = INT_MIN;
        int result = -1;

        function<void(int, int, int)> dfs = [&](int node, int parent, int currProfit) {
            currProfit += (dist[node] == 0) ? amount[node] / 2 : amount[node];
            if (graph[node].size() == 1 && node != 0) {
                if (currProfit > maxProfit) {
                    maxProfit = currProfit;
                    result = node;
                }
            }
            for (int neighbor : graph[node]) {
                if (neighbor != parent) {
                    dfs(neighbor, node, currProfit);
                }
            }
        };

        dfs(0, -1, 0);
        return result;
    }
};