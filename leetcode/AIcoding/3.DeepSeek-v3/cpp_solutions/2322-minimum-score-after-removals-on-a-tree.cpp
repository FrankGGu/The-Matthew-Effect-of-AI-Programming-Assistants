class Solution {
public:
    int minimumScore(vector<int>& nums, vector<vector<int>>& edges) {
        int n = nums.size();
        vector<vector<int>> adj(n);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<int> parent(n, -1), xor_val(n), in(n), out(n);
        int time = 0;
        function<void(int, int)> dfs = [&](int u, int p) {
            parent[u] = p;
            in[u] = time++;
            xor_val[u] = nums[u];
            for (int v : adj[u]) {
                if (v != p) {
                    dfs(v, u);
                    xor_val[u] ^= xor_val[v];
                }
            }
            out[u] = time++;
        };
        dfs(0, -1);

        int res = INT_MAX;
        for (int i = 1; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int a, b, c;
                if (in[i] < in[j] && out[i] >= out[j]) {
                    a = xor_val[j];
                    b = xor_val[i] ^ xor_val[j];
                    c = xor_val[0] ^ xor_val[i];
                } else if (in[j] < in[i] && out[j] >= out[i]) {
                    a = xor_val[i];
                    b = xor_val[j] ^ xor_val[i];
                    c = xor_val[0] ^ xor_val[j];
                } else {
                    a = xor_val[i];
                    b = xor_val[j];
                    c = xor_val[0] ^ xor_val[i] ^ xor_val[j];
                }
                int max_val = max({a, b, c});
                int min_val = min({a, b, c});
                res = min(res, max_val - min_val);
            }
        }
        return res;
    }
};