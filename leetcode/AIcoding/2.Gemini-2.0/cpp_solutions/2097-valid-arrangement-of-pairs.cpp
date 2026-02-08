#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> validArrangement(vector<vector<int>>& pairs) {
        unordered_map<int, vector<int>> adj;
        unordered_map<int, int> inDegree, outDegree;

        for (auto& pair : pairs) {
            int u = pair[0], v = pair[1];
            adj[u].push_back(v);
            outDegree[u]++;
            inDegree[v]++;
        }

        int start = pairs[0][0];
        for (auto& [node, degree] : outDegree) {
            if (outDegree[node] - inDegree[node] == 1) {
                start = node;
                break;
            }
        }

        vector<vector<int>> result;
        vector<int> path;

        function<void(int)> dfs = [&](int u) {
            while (!adj[u].empty()) {
                int v = adj[u].back();
                adj[u].pop_back();
                dfs(v);
                path.push_back(u);
                path.push_back(v);
            }
        };

        dfs(start);

        reverse(path.begin(), path.end());

        for (int i = 0; i < path.size() - 1; i += 2) {
            result.push_back({path[i], path[i + 1]});
        }

        reverse(result.begin(), result.end());

        return result;
    }
};