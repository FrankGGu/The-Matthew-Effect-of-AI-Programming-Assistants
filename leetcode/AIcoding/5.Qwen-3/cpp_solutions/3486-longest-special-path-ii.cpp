#include <iostream>
#include <vector>
#include <algorithm>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestPath(int n, vector<vector<int>>& edges, char* labels, int k) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        int result = 0;
        function<int(int, int)> dfs = [&](int node, int parent) -> int {
            vector<int> maxLengths;
            for (int neighbor : graph[node]) {
                if (neighbor == parent) continue;
                int length = dfs(neighbor, node);
                if (labels[neighbor] == labels[node]) {
                    maxLengths.push_back(length);
                }
            }

            sort(maxLengths.begin(), maxLengths.end(), greater<int>());
            int total = 0;
            for (int i = 0; i < min(k, (int)maxLengths.size()); ++i) {
                total += maxLengths[i];
            }
            result = max(result, total + 1);
            return (maxLengths.empty() ? 0 : maxLengths[0]) + 1;
        };

        dfs(0, -1);
        return result;
    }
};