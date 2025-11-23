#include <vector>
#include <algorithm>

using namespace std;

class Solution {
private:
    const int MOD = 1e9 + 7;
    vector<long long> fact, invFact;

    long long modPow(long long x, long long y) {
        long long res = 1;
        x %= MOD;
        while (y > 0) {
            if (y & 1) res = (res * x) % MOD;
            x = (x * x) % MOD;
            y >>= 1;
        }
        return res;
    }

    void precompute(int n) {
        fact.resize(n + 1);
        invFact.resize(n + 1);
        fact[0] = 1;
        for (int i = 1; i <= n; ++i) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }
        invFact[n] = modPow(fact[n], MOD - 2);
        for (int i = n - 1; i >= 0; --i) {
            invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
        }
    }

    pair<long long, long long> dfs(int u, const vector<vector<int>>& adj) {
        long long res = 1, cnt = 0;
        vector<long long> childCnts, childRess;
        for (int v : adj[u]) {
            auto [childRes, childCnt] = dfs(v, adj);
            childRess.push_back(childRes);
            childCnts.push_back(childCnt);
            cnt += childCnt;
        }
        long long ways = fact[cnt];
        for (long long c : childCnts) {
            ways = (ways * invFact[c]) % MOD;
        }
        for (long long r : childRess) {
            ways = (ways * r) % MOD;
        }
        return {ways, cnt + 1};
    }

public:
    int waysToBuildRooms(vector<int>& prevRoom) {
        int n = prevRoom.size();
        precompute(n);
        vector<vector<int>> adj(n);
        for (int i = 1; i < n; ++i) {
            adj[prevRoom[i]].push_back(i);
        }
        auto [res, _] = dfs(0, adj);
        return res;
    }
};