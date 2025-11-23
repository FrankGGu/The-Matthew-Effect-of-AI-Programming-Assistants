class Solution {
public:
    void dfs(const std::vector<std::vector<int>>& graph, int u, int target, std::vector<int>& currentPath, std::vector<std::vector<int>>& allPaths) {
        currentPath.push_back(u);

        if (u == target) {
            allPaths.push_back(currentPath);
        } else {
            for (int v : graph[u]) {
                dfs(graph, v, target, currentPath, allPaths);
            }
        }

        currentPath.pop_back();
    }

    std::vector<std::vector<int>> allPathsSourceTarget(std::vector<std::vector<int>>& graph) {
        std::vector<std::vector<int>> allPaths;
        std::vector<int> currentPath;
        int n = graph.size();

        dfs(graph, 0, n - 1, currentPath, allPaths);

        return allPaths;
    }
};