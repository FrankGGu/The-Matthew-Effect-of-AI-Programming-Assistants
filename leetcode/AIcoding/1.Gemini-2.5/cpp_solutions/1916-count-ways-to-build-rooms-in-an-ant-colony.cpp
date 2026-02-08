#include <vector>
#include <numeric>

class Solution {
public:
    long long power(long long base, long long exp) {
        long long res = 1;
        base %= 1000000007;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % 1000000007;
            base = (base * base) % 1000000007;
            exp /= 2;
        }
        return res;
    }

    long long modInverse(long long n) {
        return power(n, 1000000007 - 2);
    }

    std::vector<std::vector<int>> adj;
    std::vector<long long> dp;
    std::vector<int> subtree_size;
    std::vector<long long> fact;
    std::vector<long long> invFact;
    int N_nodes;
    const int MOD = 1000000007;

    void precompute_factorials(int n) {
        fact.resize(n + 1);
        invFact.resize(n + 1);
        fact[0] = 1;
        invFact[0] = 1;
        for (int i = 1; i <= n; ++i) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }
        invFact[n] = modInverse(fact[n]);
        for (int i = n - 1; i >= 1; --i) {
            invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
        }
    }

    void dfs(int u) {
        subtree_size[u] = 1;
        dp[u] = 1;

        for (int v : adj[u]) {
            dfs(v);
            subtree_size[u] += subtree_size[v];

            dp[u] = (dp[u] * dp[v]) % MOD;
            dp[u] = (dp[u] * invFact[subtree_size[v]]) % MOD;
        }

        dp[u] = (dp[u] * fact[subtree_size[u] - 1]) % MOD;
    }

    int waysToBuildRooms(std::vector<int>& rooms) {
        N_nodes = rooms.size();
        adj.resize(N_nodes);
        dp.resize(N_nodes);
        subtree_size.resize(N_nodes);

        for (int i = 0; i < N_nodes; ++i) {
            if (rooms[i] != -1) {
                adj[rooms[i]].push_back(i);
            }
        }

        precompute_factorials(N_nodes);

        dfs(0);

        return dp[0];
    }
};