#include <vector>
#include <numeric> // For std::iota
#include <algorithm> // For std::sort, std::swap
#include <map> // For std::map

struct DSU {
    std::vector<int> parent;
    std::vector<int> sz; // size of component
    DSU(int n) {
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0); // Initialize each element as its own parent
        sz.assign(n, 1); // Each component initially has size 1
    }

    // Find the representative (root) of the set containing element i
    // with path compression
    int find(int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent[i]);
    }

    // Unite the sets containing elements i and j
    // with union by size
    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            // Attach smaller tree under root of larger tree
            if (sz[root_i] < sz[root_j])
                std::swap(root_i, root_j);
            parent[root_j] = root_i;
            sz[root_i] += sz[root_j];
        }
    }
};

class Solution {
private:
    // Static members for sieve to be initialized once across all test cases
    static std::vector<int> spf; // Smallest Prime Factor
    static bool sieve_initialized;
    static const int MAX_POSSIBLE_VAL = 100000; // Max value for nums[i]

    // Sieve of Eratosthenes to precompute smallest prime factor for numbers up to MAX_POSSIBLE_VAL
    static void init_sieve() {
        if (sieve_initialized) return; // Sieve already initialized
        spf.resize(MAX_POSSIBLE_VAL + 1);
        std::iota(spf.begin(), spf.end(), 0); // Initialize spf[i] = i
        for (int i = 2; i * i <= MAX_POSSIBLE_VAL; ++i) {
            if (spf[i] == i) { // i is prime
                // Mark i as the smallest prime factor for its multiples
                for (int j = i * i; j <= MAX_POSSIBLE_VAL; j += i) {
                    if (spf[j] == j) { // Only update if spf[j] hasn't been found yet
                        spf[j] = i;
                    }
                }
            }
        }
        sieve_initialized = true;
    }

    // Get all unique prime factors of a number using the precomputed SPF array
    std::vector<int> get_prime_factors(int n) {
        std::vector<int> factors;
        while (n != 1) {
            int p = spf[n];
            factors.push_back(p);
            while (n % p == 0) { // Remove all occurrences of prime factor p
                n /= p;
            }
        }
        return factors;
    }

public:
    bool gcdSort(std::vector<int>& nums) {
        init_sieve(); // Ensure sieve is initialized before use

        int n = nums.size();

        // Create a sorted version of the input array
        std::vector<int> sorted_nums = nums;
        std::sort(sorted_nums.begin(), sorted_nums.end());

        DSU dsu(n); // Initialize DSU for N elements (indices of nums array)

        // Map to store a representative index for each prime factor encountered
        // prime -> an index 'i' in nums where nums[i] has 'prime' as a factor
        std::map<int, int> prime_to_index_representative;

        // Iterate through each number in the original array
        for (int i = 0; i < n; ++i) {
            int num = nums[i];
            std::vector<int> factors = get_prime_factors(num);
            for (int p : factors) {
                if (prime_to_index_representative.count(p)) {
                    // If this prime factor 'p' has been seen before,
                    // unite the current index 'i' with the previously recorded index
                    dsu.unite(i, prime_to_index_representative[p]);
                } else {
                    // If this is the first time seeing prime factor 'p',
                    // record current index 'i' as its representative
                    prime_to_index_representative[p] = i;
                }
            }
        }

        // Group original indices by their DSU component root
        std::map<int, std::vector<int>> components_original_indices;
        for (int i = 0; i < n; ++i) {
            components_original_indices[dsu.find(i)].push_back(i);
        }

        // For each connected component, check if the values within it can be sorted
        for (auto const& [root, indices] : components_original_indices) {
            std::vector<int> current_values; // Values from nums at these indices
            std::vector<int> target_values;  // Values from sorted_nums at these indices

            for (int idx : indices) {
                current_values.push_back(nums[idx]);
                target_values.push_back(sorted_nums[idx]);
            }

            // Sort both collections. If they are identical, it means the values
            // within this component can be rearranged to match the sorted order.
            std::sort(current_values.begin(), current_values.end());
            std::sort(target_values.begin(), target_values.end());

            if (current_values != target_values) {
                return false; // If any component cannot be sorted, return false
            }
        }

        return true; // All components can be sorted, so the entire array can be sorted
    }
};

std::vector<int> Solution::spf;
bool Solution::sieve_initialized = false;