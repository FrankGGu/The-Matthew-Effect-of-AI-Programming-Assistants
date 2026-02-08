#include <vector>
#include <numeric>
#include <unordered_map>
#include <algorithm>

class DSU {
public:
    std::vector<int> parent;
    std::vector<int> sz;

    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
        sz.assign(n, 1);
    }

    int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            if (sz[root_i] < sz[root_j]) {
                std::swap(root_i, root_j);
            }
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
        }
    }
};

class Solution {
public:
    int countConnectedComponents(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 0) {
            return 0;
        }

        std::unordered_map<int, int> prime_to_idx;
        DSU dsu(n);

        for (int i = 0; i < n; ++i) {
            int num = nums[i];

            for (int p = 2; p * p <= num; ++p) {
                if (num % p == 0) {
                    if (prime_to_idx.find(p) == prime_to_idx.end()) {
                        prime_to_idx[p] = i;
                    } else {
                        dsu.unite(i, prime_to_idx[p]);
                    }
                    while (num % p == 0) {
                        num /= p;
                    }
                }
            }

            if (num > 1) {
                if (prime_to_idx.find(num) == prime_to_idx.end()) {
                    prime_to_idx[num] = i;
                } else {
                    dsu.unite(i, prime_to_idx[num]);
                }
            }
        }

        int components = 0;
        for (int i = 0; i < n; ++i) {
            if (dsu.parent[i] == i) {
                components++;
            }
        }
        return components;
    }
};