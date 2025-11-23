#include <vector>

using namespace std;

class Solution {
public:
    int countWays(vector<int>& predecessors) {
        int n = predecessors.size();
        long long MOD = 1e9 + 7;

        vector<vector<int>> adj(n);
        vector<int> inDegree(n, 0);

        for (int i = 0; i < n; ++i) {
            if (predecessors[i] != -1) {
                adj[predecessors[i]].push_back(i);
                inDegree[i]++;
            }
        }

        vector<int> order;
        vector<int> q;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push_back(i);
            }
        }

        int head = 0;
        while (head < q.size()) {
            int u = q[head++];
            order.push_back(u);

            for (int v : adj[u]) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push_back(v);
                }
            }
        }

        if (order.size() != n) {
            return 0;
        }

        vector<long long> fact(n + 1);
        fact[0] = 1;
        for (int i = 1; i <= n; ++i) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        auto power = [&](long long base, long long exp) {
            long long res = 1;
            base %= MOD;
            while (exp > 0) {
                if (exp % 2 == 1) res = (res * base) % MOD;
                base = (base * base) % MOD;
                exp /= 2;
            }
            return res;
        };

        auto modInverse = [&](long long n) {
            return power(n, MOD - 2);
        };

        vector<int> subtreeSize(n, 1);
        for (int i = n - 1; i >= 0; --i) {
            int u = order[i];
            for (int v : adj[u]) {
                subtreeSize[u] += subtreeSize[v];
            }
        }

        long long ans = fact[n - 1];
        for (int i = 0; i < n; ++i) {
            int u = order[i];
            ans = (ans * modInverse(fact[subtreeSize[u] - 1])) % MOD;
        }

        return ans;
    }
};