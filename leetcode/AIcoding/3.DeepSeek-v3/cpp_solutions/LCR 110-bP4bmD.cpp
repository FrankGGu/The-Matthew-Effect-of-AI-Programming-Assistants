class Solution {
public:
    vector<vector<int>> allPathsSourceTarget(vector<vector<int>>& graph) {
        vector<vector<int>> result;
        vector<int> path;
        dfs(0, graph.size() - 1, graph, path, result);
        return result;
    }

private:
    void dfs(int current, int target, vector<vector<int>>& graph, vector<int>& path, vector<vector<int>>& result) {
        path.push_back(current);
        if (current == target) {
            result.push_back(path);
        } else {
            for (int neighbor : graph[current]) {
                dfs(neighbor, target, graph, path, result);
            }
        }
        path.pop_back();
    }
};