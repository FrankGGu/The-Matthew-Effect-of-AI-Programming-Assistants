class UnionFind {
private:
    vector<int> parent;
    vector<int> rank;
public:
    UnionFind(int size) {
        parent.resize(size);
        rank.resize(size, 0);
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
            if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
        }
    }
};

class Solution {
public:
    bool gcdSort(vector<int>& nums) {
        int max_num = *max_element(nums.begin(), nums.end());
        UnionFind uf(max_num + 1);

        for (int num : nums) {
            int temp = num;
            for (int i = 2; i * i <= temp; ++i) {
                if (temp % i == 0) {
                    uf.unite(num, i);
                    while (temp % i == 0) {
                        temp /= i;
                    }
                }
            }
            if (temp > 1) {
                uf.unite(num, temp);
            }
        }

        vector<int> sorted_nums(nums);
        sort(sorted_nums.begin(), sorted_nums.end());

        for (int i = 0; i < nums.size(); ++i) {
            if (uf.find(nums[i]) != uf.find(sorted_nums[i])) {
                return false;
            }
        }

        return true;
    }
};