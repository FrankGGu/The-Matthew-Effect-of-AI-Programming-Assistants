#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countValidPaths(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        int result = 0;
        vector<bool> visited(n, false);

        function<void(int, int, unordered_map<int, int>&)> dfs = [&](int node, int parent, unordered_map<int, int>& count) {
            count[0]++;
            for (int neighbor : graph[node]) {
                if (neighbor == parent) continue;
                dfs(neighbor, node, count);
            }
        };

        function<void(int, int)> postOrder = [&](int node, int parent) {
            unordered_map<int, int> count;
            dfs(node, -1, count);
            for (int neighbor : graph[node]) {
                if (neighbor == parent) continue;
                postOrder(neighbor, node);
            }

            for (int neighbor : graph[node]) {
                if (neighbor == parent) continue;
                unordered_map<int, int> childCount;
                dfs(neighbor, node, childCount);
                for (auto& [key, val] : childCount) {
                    count[key] += val;
                }
            }

            for (auto& [key, val] : count) {
                if (val > 0) {
                    result += val;
                }
            }
        };

        postOrder(0, -1);
        return result;
    }
};