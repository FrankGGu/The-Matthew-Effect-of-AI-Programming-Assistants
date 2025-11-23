class Solution {
public:
    vector<int> minReverseOperations(int n, int p, vector<int>& banned, int k) {
        vector<int> res(n, -1);
        unordered_set<int> ban(banned.begin(), banned.end());
        vector<set<int>> sets(2);
        for (int i = 0; i < n; ++i) {
            if (i != p && !ban.count(i)) {
                sets[i % 2].insert(i);
            }
        }
        queue<int> q;
        q.push(p);
        res[p] = 0;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            int lo = max(u - k + 1, k - 1 - u);
            int hi = min(u + k - 1, 2 * n - k - 1 - u);
            int parity = (u + k - 1) % 2;
            auto& s = sets[parity];
            auto it = s.lower_bound(lo);
            while (it != s.end() && *it <= hi) {
                int v = *it;
                res[v] = res[u] + 1;
                q.push(v);
                it = s.erase(it);
            }
        }
        return res;
    }
};