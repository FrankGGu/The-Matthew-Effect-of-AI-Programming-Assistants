class Solution {
public:
    vector<int> parent;

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSet(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootY] = rootX;
        }
    }

    int minimumHammingDistance(vector<int>& source, vector<int>& target, vector<vector<int>>& allowedSwaps) {
        int n = source.size();
        parent.resize(n);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        for (const auto& swap : allowedSwaps) {
            unionSet(swap[0], swap[1]);
        }

        unordered_map<int, unordered_multiset<int>> groups;
        for (int i = 0; i < n; ++i) {
            groups[find(i)].insert(source[i]);
        }

        int res = 0;
        for (int i = 0; i < n; ++i) {
            int root = find(i);
            auto& group = groups[root];
            auto it = group.find(target[i]);
            if (it != group.end()) {
                group.erase(it);
            } else {
                res++;
            }
        }

        return res;
    }
};