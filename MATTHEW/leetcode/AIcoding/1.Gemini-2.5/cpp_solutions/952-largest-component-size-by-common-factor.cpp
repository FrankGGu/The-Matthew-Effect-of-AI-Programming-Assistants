#include <vector>
#include <numeric>
#include <algorithm>
#include <unordered_map>

class Solution {
private:
    std::vector<int> parent;
    std::vector<int> sz;

    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            if (sz[root_i] < sz[root_j])
                std::swap(root_i, root_j);
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
        }
    }

public:
    int largestComponentSize(std::vector<int>& nums) {
        int max_val = 0;
        for (int num : nums) {
            max_val = std::max(max_val, num);
        }

        parent.resize(max_val + 1);
        std::iota(parent.begin(), parent.end(), 0);
        sz.assign(max_val + 1, 1);

        std::vector<int> spf(max_val + 1);
        std::iota(spf.begin(), spf.end(), 0);

        for (int i = 2; i * i <= max_val; ++i) {
            if (spf[i] == i) {
                for (int j = i * i; j <= max_val; j += i) {
                    if (spf[j] == j) {
                        spf[j] = i;
                    }
                }
            }
        }

        for (int num : nums) {
            int temp = num;
            while (temp > 1) {
                int p = spf[temp];
                unite(num, p);
                while (temp % p == 0) {
                    temp /= p;
                }
            }
        }

        std::unordered_map<int, int> component_counts;
        int max_size = 0;
        for (int num : nums) {
            int root = find(num);
            component_counts[root]++;
            max_size = std::max(max_size, component_counts[root]);
        }

        return max_size;
    }
};