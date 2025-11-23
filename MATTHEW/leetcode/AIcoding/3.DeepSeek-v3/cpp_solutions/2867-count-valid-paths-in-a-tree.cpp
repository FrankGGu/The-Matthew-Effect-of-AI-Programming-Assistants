class Solution {
public:
    long long countValidPairs(int n, vector<vector<int>>& edges) {
        vector<vector<int>> tree(n + 1);
        for (auto& e : edges) {
            tree[e[0]].push_back(e[1]);
            tree[e[1]].push_back(e[0]);
        }

        vector<bool> isPrime(n + 1, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= n; ++i) {
            if (isPrime[i]) {
                for (int j = i * i; j <= n; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        long long res = 0;
        vector<int> size(n + 1, 0);

        function<void(int, int)> dfs = [&](int u, int parent) {
            size[u] = 1;
            for (int v : tree[u]) {
                if (v == parent) continue;
                dfs(v, u);
                size[u] += size[v];
            }
        };

        function<void(int, int, int)> solve = [&](int u, int parent, int cnt) {
            for (int v : tree[u]) {
                if (v == parent) continue;
                if (isPrime[v]) {
                    res += (long long)(size[v]) * (cnt - size[v]);
                    solve(v, u, cnt - size[v]);
                } else {
                    solve(v, u, cnt);
                }
            }
        };

        for (int u = 1; u <= n; ++u) {
            if (isPrime[u]) {
                dfs(u, -1);
                solve(u, -1, size[u]);
            }
        }

        return res / 2;
    }
};