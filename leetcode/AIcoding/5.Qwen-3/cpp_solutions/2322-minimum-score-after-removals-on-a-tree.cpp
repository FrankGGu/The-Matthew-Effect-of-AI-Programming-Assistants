#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minScore(int n, vector<vector<int>>& edges) {
        unordered_map<int, vector<int>> graph;
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n + 1, false);
        vector<int> subtreeSum(n + 1, 0);

        function<int(int)> dfs = [&](int node) {
            visited[node] = true;
            int sum = 1;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    sum += dfs(neighbor);
                }
            }
            subtreeSum[node] = sum;
            return sum;
        };

        dfs(1);

        int total = subtreeSum[1];
        int minScore = INT_MAX;

        for (int i = 2; i <= n; ++i) {
            int parent = -1;
            for (int j = 1; j <= n; ++j) {
                if (graph[j].size() > 0 && subtreeSum[j] == subtreeSum[i]) {
                    parent = j;
                    break;
                }
            }
            if (parent != -1) {
                int part1 = subtreeSum[i];
                int part2 = total - part1;
                minScore = min(minScore, abs(part1 - part2));
            }
        }

        return minScore;
    }
};