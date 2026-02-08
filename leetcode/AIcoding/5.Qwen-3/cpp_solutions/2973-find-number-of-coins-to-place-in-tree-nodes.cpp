#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findNumberOfCoins(vector<int>& coins, vector<vector<int>>& edges) {
        int n = coins.size();
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> visited(n, 0);
        vector<int> result(n, 0);

        function<void(int, int)> dfs = [&](int node, int parent) {
            visited[node] = 1;
            for (int neighbor : graph[node]) {
                if (neighbor != parent) {
                    dfs(neighbor, node);
                    result[node] += result[neighbor];
                }
            }
            result[node] += coins[node];
        };

        dfs(0, -1);

        return result[0];
    }
};