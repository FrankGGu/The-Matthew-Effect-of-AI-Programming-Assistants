class Solution {
public:
    vector<int> getCoprimes(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        vector<vector<int>> adj(n);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<int> res(n, -1);
        vector<vector<pair<int, int>>> path(51);
        dfs(0, -1, 0, nums, adj, path, res);
        return res;
    }

    void dfs(int u, int parent, int depth, vector<int>& nums, vector<vector<int>>& adj, vector<vector<pair<int, int>>>& path, vector<int>& res) {
        int max_depth = -1;
        for (int x = 1; x <= 50; ++x) {
            if (!path[x].empty() && gcd(x, nums[u]) == 1) {
                auto [d, node] = path[x].back();
                if (d > max_depth) {
                    max_depth = d;
                    res[u] = node;
                }
            }
        }

        path[nums[u]].emplace_back(depth, u);
        for (int v : adj[u]) {
            if (v != parent) {
                dfs(v, u, depth + 1, nums, adj, path, res);
            }
        }
        path[nums[u]].pop_back();
    }
};