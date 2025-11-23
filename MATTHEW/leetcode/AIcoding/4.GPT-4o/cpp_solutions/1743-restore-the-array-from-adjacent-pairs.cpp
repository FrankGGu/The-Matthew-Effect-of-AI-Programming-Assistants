#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    vector<int> restoreArray(vector<vector<int>>& adjacentPairs) {
        unordered_map<int, vector<int>> graph;
        for (const auto& pair : adjacentPairs) {
            graph[pair[0]].push_back(pair[1]);
            graph[pair[1]].push_back(pair[0]);
        }

        vector<int> result;
        vector<bool> visited(100001, false);
        int start = adjacentPairs[0][0];
        dfs(graph, start, visited, result);
        return result;
    }

    void dfs(unordered_map<int, vector<int>>& graph, int node, vector<bool>& visited, vector<int>& result) {
        visited[node] = true;
        result.push_back(node);
        for (int neighbor : graph[node]) {
            if (!visited[neighbor]) {
                dfs(graph, neighbor, visited, result);
            }
        }
    }
};