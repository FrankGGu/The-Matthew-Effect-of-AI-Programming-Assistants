class UnionFind {
private:
    vector<int> parent;
    vector<int> rank;
public:
    UnionFind(int size) {
        parent.resize(size);
        rank.resize(size, 1);
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

    void unite(int x, int y) {
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
};

class Solution {
public:
    bool canTraverseAllPairs(vector<int>& nums) {
        int n = nums.size();
        if (n == 1) return true;

        UnionFind uf(n);
        unordered_map<int, int> primeToIndex;

        for (int i = 0; i < n; ++i) {
            int num = nums[i];
            if (num == 1) return false;

            for (int p = 2; p * p <= num; ++p) {
                if (num % p == 0) {
                    if (primeToIndex.count(p)) {
                        uf.unite(i, primeToIndex[p]);
                    } else {
                        primeToIndex[p] = i;
                    }
                    while (num % p == 0) {
                        num /= p;
                    }
                }
            }
            if (num > 1) {
                if (primeToIndex.count(num)) {
                    uf.unite(i, primeToIndex[num]);
                } else {
                    primeToIndex[num] = i;
                }
            }
        }

        int root = uf.find(0);
        for (int i = 1; i < n; ++i) {
            if (uf.find(i) != root) {
                return false;
            }
        }
        return true;
    }
};