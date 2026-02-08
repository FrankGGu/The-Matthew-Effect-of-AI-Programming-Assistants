#include <vector>
#include <numeric>

class Solution {
public:
    long long MOD = 1e9 + 7;
    std::vector<std::vector<long long>> combinations;

    void precompute_combinations_internal(int n) {
        combinations.resize(n + 1, std::vector<long long>(n + 1));
        for (int i = 0; i <= n; ++i) {
            combinations[i][0] = 1;
            for (int j = 1; j <= i; ++j) {
                combinations[i][j] = (combinations[i-1][j-1] + combinations[i-1][j]) % MOD;
            }
        }
    }

    long long solve_internal(std::vector<int>& nums) {
        int n = nums.size();
        if (n <= 2) {
            return 1;
        }

        int root_val = nums[0];
        std::vector<int> left_subtree_elements;
        std::vector<int> right_subtree_elements;

        for (int i = 1; i < n; ++i) {
            if (nums[i] < root_val) {
                left_subtree_elements.push_back(nums[i]);
            } else {
                right_subtree_elements.push_back(nums[i]);
            }
        }

        long long ways_left = solve_internal(left_subtree_elements);
        long long ways_right = solve_internal(right_subtree_elements);

        int L = left_subtree_elements.size();
        int R = right_subtree_elements.size();

        long long ways_interleave = combinations[L + R][L];

        long long total_ways = (ways_interleave * ways_left) % MOD;
        total_ways = (total_ways * ways_right) % MOD;

        return total_ways;
    }

    int numOfWays(std::vector<int>& nums) {
        int n = nums.size();
        precompute_combinations_internal(n);

        return (solve_internal(nums) - 1 + MOD) % MOD;
    }
};