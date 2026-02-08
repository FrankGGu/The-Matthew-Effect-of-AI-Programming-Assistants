#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countServers(int n, vector<vector<int>>& edges) {
        unordered_map<int, vector<int>> graph;
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            graph[u].push_back(v);
            graph[v].push_back(u);
        }

        vector<bool> visited(n, false);
        int count = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                vector<int> nodes;
                vector<int> connections;
                bool isLeaf = true;
                int size = 0;

                dfs(i, graph, visited, nodes, connections, size, isLeaf);

                if (!isLeaf) {
                    count += size;
                }
            }
        }

        return count;
    }

private:
    void dfs(int node, const unordered_map<int, vector<int>>& graph, vector<bool>& visited, vector<int>& nodes, vector<int>& connections, int& size, bool& isLeaf) {
        visited[node] = true;
        nodes.push_back(node);
        size++;

        for (int neighbor : graph.at(node)) {
            if (!visited[neighbor]) {
                connections.push_back(neighbor);
                dfs(neighbor, graph, visited, nodes, connections, size, isLeaf);
            }
        }

        if (connections.size() > 1) {
            isLeaf = false;
        } else if (connections.size() == 1) {
            isLeaf = false;
        }
    }
};