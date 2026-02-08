#include <vector>

using namespace std;

class Solution {
public:
    vector<int> gardenNoAdj(int n, vector<vector<int>>& paths) {
        vector<vector<int>> adj(n);
        for (auto& path : paths) {
            adj[path[0] - 1].push_back(path[1] - 1);
            adj[path[1] - 1].push_back(path[0] - 1);
        }

        vector<int> result(n, 0);
        for (int i = 0; i < n; ++i) {
            vector<bool> used(5, false);
            for (int neighbor : adj[i]) {
                if (result[neighbor] != 0) {
                    used[result[neighbor]] = true;
                }
            }
            for (int j = 1; j <= 4; ++j) {
                if (!used[j]) {
                    result[i] = j;
                    break;
                }
            }
        }

        return result;
    }
};