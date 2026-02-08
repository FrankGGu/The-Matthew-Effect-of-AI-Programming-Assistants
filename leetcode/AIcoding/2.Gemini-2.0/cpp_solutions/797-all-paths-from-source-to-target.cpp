#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> allPathsSourceTarget(vector<vector<int>>& graph) {
        vector<vector<int>> paths;
        vector<int> currentPath;
        int target = graph.size() - 1;

        function<void(int)> dfs = [&](int node) {
            currentPath.push_back(node);

            if (node == target) {
                paths.push_back(currentPath);
            } else {
                for (int neighbor : graph[node]) {
                    dfs(neighbor);
                }
            }

            currentPath.pop_back();
        };

        dfs(0);
        return paths;
    }
};