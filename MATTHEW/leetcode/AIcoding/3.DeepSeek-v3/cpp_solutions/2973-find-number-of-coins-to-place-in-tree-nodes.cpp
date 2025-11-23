#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> coins;
    vector<vector<int>> tree;
    unordered_map<int, int> memo;

    int dfs(int node, int parent) {
        int key = node * 100000 + parent;
        if (memo.count(key)) {
            return memo[key];
        }
        int res = coins[node];
        for (int child : tree[node]) {
            if (child != parent) {
                res ^= dfs(child, node);
            }
        }
        memo[key] = res;
        return res;
    }

    vector<int> placedCoins(vector<vector<int>>& edges, vector<int>& cost) {
        int n = cost.size();
        coins = cost;
        tree.resize(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1];
            tree[u].push_back(v);
            tree[v].push_back(u);
        }

        vector<int> res(n);
        for (int i = 0; i < n; ++i) {
            vector<int> values;
            for (int child : tree[i]) {
                values.push_back(dfs(child, i));
            }
            if (values.size() < 2) {
                res[i] = 1;
            } else {
                sort(values.begin(), values.end());
                int m = values.size();
                long long max1 = (long long)values[m-1] * values[m-2];
                long long max2 = (long long)values[0] * values[1];
                long long max_val = max(max1, max2);
                res[i] = max_val > 0 ? 0 : 1;
            }
        }
        return res;
    }
};