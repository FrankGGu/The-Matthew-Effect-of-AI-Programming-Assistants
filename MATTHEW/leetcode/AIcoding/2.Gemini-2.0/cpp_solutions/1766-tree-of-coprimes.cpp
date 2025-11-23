#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<int> getCoprimes(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> ans(n, -1);
        vector<pair<int, int>> ancestors[51];

        function<void(int, int, int)> dfs = [&](int u, int parent, int depth) {
            int best_ancestor = -1;
            int best_depth = -1;
            for (int i = 1; i <= 50; ++i) {
                if (gcd(nums[u], i) == 1 && !ancestors[i].empty()) {
                    if (ancestors[i].back().second > best_depth) {
                        best_depth = ancestors[i].back().second;
                        best_ancestor = ancestors[i].back().first;
                    }
                }
            }
            ans[u] = best_ancestor;

            ancestors[nums[u]].push_back({u, depth});
            for (int v : adj[u]) {
                if (v != parent) {
                    dfs(v, u, depth + 1);
                }
            }
            ancestors[nums[u]].pop_back();
        };

        dfs(0, -1, 0);
        return ans;
    }
};