#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> sumOfDistancesInTree(int n, vector<vector<int>>& edges) {
        vector<int> result(n, 0);
        vector<int> count(n, 1);
        vector<vector<int>> graph(n);

        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        function<void(int, int)> dfs = [&](int node, int parent) {
            for (int neighbor : graph[node]) {
                if (neighbor != parent) {
                    dfs(neighbor, node);
                    count[node] += count[neighbor];
                    result[node] += result[neighbor] + count[neighbor];
                }
            }
        };

        function<void(int, int)> postDfs = [&](int node, int parent) {
            for (int neighbor : graph[node]) {
                if (neighbor != parent) {
                    result[neighbor] = result[node] - count[neighbor] + (n - count[neighbor]);
                    postDfs(neighbor, node);
                }
            }
        };

        dfs(0, -1);
        postDfs(0, -1);

        return result;
    }
};