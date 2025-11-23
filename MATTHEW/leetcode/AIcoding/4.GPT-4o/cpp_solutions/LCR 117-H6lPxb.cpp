class UnionFind {
public:
    vector<int> parent;
    UnionFind(int size) {
        parent.resize(size);
        for (int i = 0; i < size; i++) {
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
            parent[rootX] = rootY;
        }
    }
};

class Solution {
public:
    bool isSimilar(string& a, string& b) {
        int count = 0;
        for (int i = 0; i < a.size(); i++) {
            if (a[i] != b[i]) {
                count++;
                if (count > 2) return false;
            }
        }
        return count == 2 || count == 0;
    }

    int numSimilarGroups(vector<string>& strs) {
        int n = strs.size();
        UnionFind uf(n);

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (isSimilar(strs[i], strs[j])) {
                    uf.unionSet(i, j);
                }
            }
        }

        unordered_set<int> uniqueGroups;
        for (int i = 0; i < n; i++) {
            uniqueGroups.insert(uf.find(i));
        }

        return uniqueGroups.size();
    }
};