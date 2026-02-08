#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> gardenNoAdj(int n, vector<vector<int>>& paths) {
        vector<vector<int>> graph(n);
        for (const auto& path : paths) {
            int u = path[0] - 1;
            int v = path[1] - 1;
            graph[u].push_back(v);
            graph[v].push_back(u);
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