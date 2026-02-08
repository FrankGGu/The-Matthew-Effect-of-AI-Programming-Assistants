#include <vector>
#include <numeric> // For std::iota
#include <algorithm> // For std::swap

class DSU {
public:
    std::vector<int> parent;
    std::vector<int> sz; // size of component
    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
        sz.assign(n, 1);
    }

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
};

const int MAX_VAL = 100000;
std::vector<int> spf(MAX_VAL + 1); // smallest prime factor

void sieve_init() {
    std::iota(spf.begin(), spf.end(), 0); // spf[i] = i initially
    for (int i = 2; i * i <= MAX_VAL; ++i) {
        if (spf[i] == i) { // i is prime
            for (int j = i * i; j <= MAX_VAL; j += i) {
                if (spf[j] == j) { // only update if j hasn't been visited by a smaller prime
                    spf[j] = i;
                }
            }
        }
    }
}

class Solution {
public:
    static bool sieve_initialized;

    bool canTraverseAllPairs(std::vector<int>& nums) {
        int n = nums.size();
        if (n == 1) {
            return true;
        }

        if (!sieve_initialized) {
            sieve_init();
            sieve_initialized = true;
        }

        bool all_ones = true;
        for (int x : nums) {
            if (x != 1) {
                all_ones = false;
                break;
            }
        }
        if (all_ones) {
            return false;
        }

        DSU dsu(MAX_VAL + 1); 

        for (int i = 0; i < n; ++i) {
            int num = nums[i];
            if (num == 1) continue; 

            int temp_num = num;
            while (temp_num > 1) {
                int p = spf[temp_num];
                dsu.unite(i, p); 
                while (temp_num > 1 && temp_num % p == 0) {
                    temp_num /= p;
                }
            }
        }

        int root_of_first_element = dsu.find(0);
        for (int i = 1; i < n; ++i) {
            if (dsu.find(i) != root_of_first_element) {
                return false;
            }
        }

        return true;
    }
};

bool Solution::sieve_initialized = false;