using namespace std;

class Solution {
public:
    vector<int> gardenNoAdj(int n, vector<vector<int>>& paths) {
        vector<vector<int>> graph(n);
        for (const auto& path : paths) {
            int u = path[0] - 1, v = path[1] - 1;
            graph[u].push_back(v);
            graph[v].push_back(u);
        }

        vector<int> res(n, 0);
        for (int i = 0; i < n; ++i) {
            vector<bool> used(5, false);
            for (int neighbor : graph[i]) {
                if (res[neighbor] != 0) {
                    used[res[neighbor]] = true;
                }
            }
            for (int color = 1; color <= 4; ++color) {
                if (!used[color]) {
                    res[i] = color;
                    break;
                }
            }
        }
        return res;
    }
};