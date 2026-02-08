class UnionFind {
public:
    UnionFind(int n) : parent(n), rank(n, 0) {
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }
    }

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

class Solution {
public:
    string smallestStringWithSwaps(string s, vector<vector<int>>& pairs) {
        int n = s.size();
        UnionFind uf(n);
        for (const auto& pair : pairs) {
            uf.unionSet(pair[0], pair[1]);
        }

        unordered_map<int, vector<int>> groups;
        for (int i = 0; i < n; ++i) {
            groups[uf.find(i)].push_back(i);
        }

        for (auto& [root, indices] : groups) {
            vector<char> chars;
            for (int idx : indices) {
                chars.push_back(s[idx]);
            }
            sort(chars.begin(), chars.end());
            sort(indices.begin(), indices.end());
            for (int i = 0; i < indices.size(); ++i) {
                s[indices[i]] = chars[i];
            }
        }

        return s;
    }
};