#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countWays(int n, vector<int>& parent) {
        vector<vector<int>> children(n);
        for (int i = 1; i < n; ++i) {
            children[parent[i]].push_back(i);
        }

        vector<long long> fact(n + 1, 1);
        for (int i = 2; i <= n; ++i) {
            fact[i] = fact[i - 1] * i;
        }

        vector<long long> inv_fact(n + 1, 1);
        inv_fact[n] = pow(fact[n], n - 2);
        for (int i = n - 1; i >= 0; --i) {
            inv_fact[i] = inv_fact[i + 1] * (i + 1) % (1000000007);
        }

        function<pair<long long, long long>(int)> dfs = [&](int node) -> pair<long long, long long> {
            long long size = 1;
            long long ways = 1;
            for (int child : children[node]) {
                auto [child_size, child_ways] = dfs(child);
                size += child_size;
                ways = ways * child_ways % 1000000007;
                ways = ways * inv_fact[child_size] % 1000000007;
            }
            ways = ways * fact[size - 1] % 1000000007;
            return {size, ways};
        };

        return dfs(0).second;
    }

private:
    long long pow(long long a, long long b) {
        long long res = 1;
        while (b > 0) {
            if (b % 2 == 1) {
                res = res * a % 1000000007;
            }
            a = a * a % 1000000007;
            b /= 2;
        }
        return res;
    }
};