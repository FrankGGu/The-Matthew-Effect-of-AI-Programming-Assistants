class Solution {
public:
    vector<bool> checkIfPrerequisite(int n, vector<vector<int>>& prerequisites, vector<vector<int>>& queries) {
        vector<vector<int>> graph(n);
        vector<vector<bool>> reach(n, vector<bool>(n, false));

        for (const auto& pre : prerequisites) {
            graph[pre[0]].push_back(pre[1]);
            reach[pre[0]][pre[1]] = true;
        }

        for (int i = 0; i < n; ++i) {
            reach[i][i] = true;
        }

        for (int k = 0; k < n; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    reach[i][j] = reach[i][j] || (reach[i][k] && reach[k][j]);
                }
            }
        }

        vector<bool> result;
        for (const auto& query : queries) {
            result.push_back(reach[query[0]][query[1]]);
        }

        return result;
    }
};