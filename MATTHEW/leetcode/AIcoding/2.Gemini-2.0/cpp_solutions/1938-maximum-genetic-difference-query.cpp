#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> maxGeneticDifference(vector<int>& parents, vector<vector<int>>& queries) {
        int n = parents.size();
        vector<vector<int>> adj(n);
        int root = -1;
        for (int i = 0; i < n; ++i) {
            if (parents[i] == -1) {
                root = i;
            } else {
                adj[parents[i]].push_back(i);
            }
        }

        vector<int> ans(queries.size());
        vector<int> path;
        function<void(int, int)> dfs = [&](int u, int xor_val) {
            path.push_back(u);

            for (int i = 0; i < queries.size(); ++i) {
                if (queries[i][0] == u) {
                    int val = queries[i][1];
                    int max_xor = 0;
                    for (int node : path) {
                        max_xor = max(max_xor, node ^ val);
                    }
                    ans[i] = max_xor;
                }
            }

            for (int v : adj[u]) {
                dfs(v, xor_val ^ v);
            }

            path.pop_back();
        };

        function<void(int)> solve = [&](int u) {
            path.push_back(u);

            for (int i = 0; i < queries.size(); ++i) {
                if (queries[i][0] == u) {
                    int val = queries[i][1];
                    int max_xor = 0;
                    for (int node : path) {
                        max_xor = max(max_xor, node ^ val);
                    }
                    ans[i] = max_xor;
                }
            }

            for (int v : adj[u]) {
                solve(v);
            }

            path.pop_back();
        };

        solve(root);

        return ans;
    }
};