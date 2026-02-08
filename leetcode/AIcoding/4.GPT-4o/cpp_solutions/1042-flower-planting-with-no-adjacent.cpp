class Solution {
public:
    vector<int> gardenNoAdj(int n, vector<vector<int>>& paths) {
        vector<vector<int>> graph(n);
        for (const auto& path : paths) {
            graph[path[0] - 1].push_back(path[1] - 1);
            graph[path[1] - 1].push_back(path[0] - 1);
        }

        vector<int> result(n, 0);
        for (int i = 0; i < n; ++i) {
            vector<bool> used(5, false);
            for (int neighbor : graph[i]) {
                if (result[neighbor] != 0) {
                    used[result[neighbor]] = true;
                }
            }
            for (int color = 1; color <= 4; ++color) {
                if (!used[color]) {
                    result[i] = color;
                    break;
                }
            }
        }
        return result;
    }
};