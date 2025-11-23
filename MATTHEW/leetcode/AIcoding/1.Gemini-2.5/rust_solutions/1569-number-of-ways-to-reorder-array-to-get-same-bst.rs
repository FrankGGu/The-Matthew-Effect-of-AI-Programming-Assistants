struct Solution;

impl Solution {
    const MOD: i64 = 1_000_000_007;

    // Precompute combinations (Pascal's Triangle)
    // combinations[n][k] stores C(n, k) % MOD
    fn precompute_combinations(max_n: usize) -> Vec<Vec<i64>> {
        let mut combinations = vec![vec![0; max_n + 1]; max_n + 1];

        for i in 0..=max_n {
            combinations[i][0] = 1;
            for j in 1..=i {
                combinations[i][j] = (combinations[i - 1][j - 1] + combinations[i - 1][j]) % Self::MOD;
            }
        }
        combinations
    }

    fn dfs(nums: &[i32], combinations: &Vec<Vec<i64>>) -> i64 {
        let n = nums.len();
        if n <= 2 {
            // Base case: For 0, 1, or 2 elements, there's only 1 way to form the same BST.
            // Example: [5] -> 1 way. [5,2] -> 1 way (5 is root, 2 is left child).
            return 1;
        }

        let root = nums[0];
        let mut left_subtree_elements = Vec::new();
        let mut right_subtree_elements = Vec::new();

        for &num in nums.iter().skip(1) {
            if num < root {
                left_subtree_elements.push(num);
            } else { // num > root, since all elements are distinct
                right_subtree_elements.push(num);
            }
        }

        let left_count = left_subtree_elements.len();
        let right_count = right_subtree_elements.len();

        let ways_left = Self::dfs(&left_subtree_elements, combinations);
        let ways_right = Self::dfs(&right_subtree_elements, combinations);

        // The number of ways to interleave `left_count` elements and `right_count` elements
        // is C(left_count + right_count, left_count).
        // This is multiplied by the number of ways to form the left subtree and right subtree recursively.
        let total_interleave_ways = combinations[left_count + right_count][left_count];

        let mut total_ways = (total_interleave_ways * ways_left) % Self::MOD;
        total_ways = (total_ways * ways_right) % Self::MOD;

        total_ways
    }

    pub fn num_of_ways(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 2 {
            // For 0, 1, or 2 elements, there are no *other* ways to reorder
            // to get the same BST (only the original order works).
            return 0;
        }

        let combinations = Self::precompute_combinations(n);
        let result = Self::dfs(&nums, &combinations);

        // Subtract 1 for the original array order itself, as the problem asks for "number of ways to reorder"
        // which implies excluding the original order.
        ((result - 1 + Self::MOD) % Self::MOD) as i32
    }
}