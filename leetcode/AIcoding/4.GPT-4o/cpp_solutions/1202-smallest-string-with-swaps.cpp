class Solution {
public:
    string smallestStringWithSwaps(string s, vector<vector<int>>& pairs) {
        int n = s.size();
        UnionFind uf(n);
        for (const auto& p : pairs) {
            uf.unionSets(p[0], p[1]);
        }
        unordered_map<int, vector<char>> groups;
        for (int i = 0; i < n; ++i) {
            groups[uf.find(i)].push_back(s[i]);
        }
        for (auto& group : groups) {
            sort(group.second.begin(), group.second.end());
        }
        string result(n, ' ');
        for (int i = 0; i < n; ++i) {
            result[i] = groups[uf.find(i)].back();
            groups[uf.find(i)].pop_back();
        }
        return result;
    }

private:
    class UnionFind {
    public:
        UnionFind(int size) : parent(size), rank(size, 1) {
            for (int i = 0; i < size; ++i) {
                parent[i] = i;
            }
        }

        int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
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
                    rank[rootX]++;
                }
            }
        }

    private:
        vector<int> parent;
        vector<int> rank;
    };
};