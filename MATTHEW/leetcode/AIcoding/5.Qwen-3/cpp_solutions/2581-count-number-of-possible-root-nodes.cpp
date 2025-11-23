#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int possibleRootNodes(vector<vector<int>>& edges, int n, int x) {
        unordered_map<int, vector<int>> graph;
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        unordered_set<int> visited;
        vector<int> subtreeSizes(n + 1, 0);

        function<void(int, int)> dfs = [&](int node, int parent) {
            subtreeSizes[node] = 1;
            for (int neighbor : graph[node]) {
                if (neighbor != parent) {
                    dfs(neighbor, node);
                    subtreeSizes[node] += subtreeSizes[neighbor];
                }
            }
        };

        dfs(x, -1);

        int result = 0;
        for (int i = 1; i <= n; ++i) {
            if (i == x) continue;
            bool isRoot = true;
            visited.clear();
            queue<int> q;
            q.push(i);
            visited.insert(i);
            int count = 0;
            while (!q.empty()) {
                int node = q.front();
                q.pop();
                count++;
                for (int neighbor : graph[node]) {
                    if (visited.find(neighbor) == visited.end()) {
                        visited.insert(neighbor);
                        q.push(neighbor);
                    }
                }
            }
            if (count == subtreeSizes[x]) {
                result++;
            }
        }

        return result;
    }
};