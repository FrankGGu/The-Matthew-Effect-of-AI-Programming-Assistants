#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int connectTrees(int n, vector<vector<int>>& edges, int x, int y) {
        unordered_map<int, vector<int>> graph;
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        int count = 0;

        function<void(int)> dfs = [&](int node) {
            visited[node] = true;
            count++;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    dfs(neighbor);
                }
            }
        };

        dfs(x);

        return count;
    }
};