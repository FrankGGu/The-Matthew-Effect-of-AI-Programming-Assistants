#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    vector<int> bonus(int n, vector<vector<int>>& leadership, vector<vector<int>>& operations) {
        vector<vector<int>> children(n + 1);
        for (const auto& l : leadership) {
            children[l[0]].push_back(l[1]);
        }

        vector<int> in(n + 1), out(n + 1);
        int time = 0;
        dfs(1, children, in, out, time);

        vector<long long> tree(n * 2 + 2, 0);
        vector<long long> lazy(n * 2 + 2, 0);
        vector<int> res;
        const int MOD = 1e9 + 7;

        for (const auto& op : operations) {
            if (op[0] == 1) {
                int u = op[1];
                int val = op[2];
                updateRange(tree, lazy, in[u], in[u], val, 1, 1, n);
            } else if (op[0] == 2) {
                int u = op[1];
                int val = op[2];
                updateRange(tree, lazy, in[u], out[u], val, 1, 1, n);
            } else if (op[0] == 3) {
                int u = op[1];
                long long sum = queryRange(tree, lazy, in[u], out[u], 1, 1, n);
                res.push_back(sum % MOD);
            }
        }
        return res;
    }

private:
    void dfs(int u, const vector<vector<int>>& children, vector<int>& in, vector<int>& out, int& time) {
        in[u] = ++time;
        for (int v : children[u]) {
            dfs(v, children, in, out, time);
        }
        out[u] = time;
    }

    void pushDown(vector<long long>& tree, vector<long long>& lazy, int node, int l, int r) {
        if (lazy[node] == 0) return;
        int mid = (l + r) / 2;
        tree[node * 2] += lazy[node] * (mid - l + 1);
        tree[node * 2 + 1] += lazy[node] * (r - mid);
        lazy[node * 2] += lazy[node];
        lazy[node * 2 + 1] += lazy[node];
        lazy[node] = 0;
    }

    void updateRange(vector<long long>& tree, vector<long long>& lazy, int L, int R, int val, int node, int l, int r) {
        if (r < L || l > R) return;
        if (L <= l && r <= R) {
            tree[node] += (long long)val * (r - l + 1);
            lazy[node] += val;
            return;
        }
        pushDown(tree, lazy, node, l, r);
        int mid = (l + r) / 2;
        updateRange(tree, lazy, L, R, val, node * 2, l, mid);
        updateRange(tree, lazy, L, R, val, node * 2 + 1, mid + 1, r);
        tree[node] = tree[node * 2] + tree[node * 2 + 1];
    }

    long long queryRange(vector<long long>& tree, vector<long long>& lazy, int L, int R, int node, int l, int r) {
        if (r < L || l > R) return 0;
        if (L <= l && r <= R) return tree[node];
        pushDown(tree, lazy, node, l, r);
        int mid = (l + r) / 2;
        return queryRange(tree, lazy, L, R, node * 2, l, mid) + 
               queryRange(tree, lazy, L, R, node * 2 + 1, mid + 1, r);
    }
};