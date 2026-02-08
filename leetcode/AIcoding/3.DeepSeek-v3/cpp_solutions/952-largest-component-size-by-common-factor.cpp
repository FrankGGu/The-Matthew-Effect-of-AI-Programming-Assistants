class UnionFind {
private:
    vector<int> parent;
    vector<int> rank;
public:
    UnionFind(int n) {
        parent.resize(n);
        rank.resize(n, 1);
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

    void unite(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
                rank[rootX] += rank[rootY];
            } else {
                parent[rootX] = rootY;
                rank[rootY] += rank[rootX];
            }
        }
    }

    int getSize(int x) {
        return rank[find(x)];
    }
};

class Solution {
public:
    int largestComponentSize(vector<int>& nums) {
        int maxNum = *max_element(nums.begin(), nums.end());
        UnionFind uf(maxNum + 1);

        for (int num : nums) {
            for (int i = 2; i * i <= num; ++i) {
                if (num % i == 0) {
                    uf.unite(num, i);
                    uf.unite(num, num / i);
                }
            }
        }

        unordered_map<int, int> count;
        int maxSize = 0;
        for (int num : nums) {
            int root = uf.find(num);
            count[root]++;
            maxSize = max(maxSize, count[root]);
        }

        return maxSize;
    }
};