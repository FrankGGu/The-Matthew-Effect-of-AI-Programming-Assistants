class Solution {
public:
    int minimizeHammingDistance(vector<int>& source, vector<int>& target, vector<vector<int>>& allowedSwaps) {
        int n = source.size();
        UnionFind uf(n);

        for (const auto& swap : allowedSwaps) {
            uf.unionSets(swap[0], swap[1]);
        }

        unordered_map<int, vector<int>> groups;
        for (int i = 0; i < n; ++i) {
            groups[uf.find(i)].push_back(source[i]);
        }

        int result = 0;
        for (auto& [_, group] : groups) {
            sort(group.begin(), group.end());
            vector<int> targetGroup;
            for (int i = 0; i < n; ++i) {
                if (uf.find(i) == _) targetGroup.push_back(target[i]);
            }
            sort(targetGroup.begin(), targetGroup.end());
            result += group.size() - count_if(group.begin(), group.end(), [&](int x) {
                return binary_search(targetGroup.begin(), targetGroup.end(), x);
            });
        }

        return result;
    }

private:
    class UnionFind {
    public:
        UnionFind(int size) : parent(size), rank(size, 1) {
            for (int i = 0; i < size; ++i) parent[i] = i;
        }

        int find(int x) {
            if (parent[x] != x) parent[x] = find(parent[x]);
            return parent[x];
        }

        void unionSets(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                if (rank[rootX] > rank[rootY]) {
                    parent[rootY] = rootX;
                } else if (rank[rootX] < rank[rootY]) {
                    parent[rootX] = rootY;
                } else {
                    parent[rootY] = rootX;
                    ++rank[rootX];
                }
            }
        }

    private:
        vector<int> parent;
        vector<int> rank;
    };
};