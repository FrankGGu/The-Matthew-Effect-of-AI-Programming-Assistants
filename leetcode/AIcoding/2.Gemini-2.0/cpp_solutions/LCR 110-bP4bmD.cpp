#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> allPathsSourceTarget(vector<vector<int>>& graph) {
        vector<vector<int>> result;
        vector<int> path;
        path.push_back(0);
        dfs(graph, 0, path, result);
        return result;
    }

private:
    void dfs(vector<vector<int>>& graph, int node, vector<int>& path, vector<vector<int>>& result) {
        if (node == graph.size() - 1) {
            result.push_back(path);
            return;
        }

        for (int neighbor : graph[node]) {
            path.push_back(neighbor);
            dfs(graph, neighbor, path, result);
            path.pop_back();
        }
    }
};