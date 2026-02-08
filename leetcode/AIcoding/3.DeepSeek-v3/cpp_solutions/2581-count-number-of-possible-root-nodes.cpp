class Solution {
public:
    int rootCount(vector<vector<int>>& edges, vector<vector<int>>& guesses, int k) {
        int n = edges.size() + 1;
        vector<vector<int>> adj(n);
        for (const auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        set<pair<int, int>> guess_set;
        for (const auto& g : guesses) {
            guess_set.insert({g[0], g[1]});
        }

        int correct = 0;
        function<void(int, int)> dfs = [&](int u, int parent) {
            for (int v : adj[u]) {
                if (v != parent) {
                    if (guess_set.count({u, v})) {
                        correct++;
                    }
                    dfs(v, u);
                }
            }
        };
        dfs(0, -1);

        int res = 0;
        function<void(int, int, int)> reroot = [&](int u, int parent, int cnt) {
            if (cnt >= k) {
                res++;
            }
            for (int v : adj[u]) {
                if (v != parent) {
                    int new_cnt = cnt;
                    if (guess_set.count({u, v})) {
                        new_cnt--;
                    }
                    if (guess_set.count({v, u})) {
                        new_cnt++;
                    }
                    reroot(v, u, new_cnt);
                }
            }
        };
        reroot(0, -1, correct);

        return res;
    }
};