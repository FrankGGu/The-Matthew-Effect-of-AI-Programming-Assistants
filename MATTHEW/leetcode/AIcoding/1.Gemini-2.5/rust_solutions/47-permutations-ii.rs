impl Solution {
    pub fn permute_unique(mut nums: Vec<i32>) -> Vec<Vec<i32>> {
        nums.sort();
        let n = nums.len();
        let mut result: Vec<Vec<i32>> = Vec::new();
        let mut current_permutation: Vec<i32> = Vec::with_capacity(n);
        let mut used: Vec<bool> = vec![false; n];

        Self::backtrack(&nums, &mut used, &mut current_permutation, &mut result);

        result
    }

    fn backtrack(
        nums: &[i32],
        used: &mut Vec<bool>,
        current_permutation: &mut Vec<i32>,
        result: &mut Vec<Vec<i32>>,
    ) {
        if current_permutation.len() == nums.len() {
            result.push(current_permutation.clone());
            return;
        }

        for i in 0..nums.len() {
            if used[i] {
                continue;
            }

            // Skip duplicates:
            // If the current element is the same as the previous one,
            // AND the previous one was NOT used (meaning it's available at the current recursion level),
            // then we have already considered this permutation path by using the previous duplicate.
            // This prevents generating identical permutations like [1_a, 2, 1_b] and [1_b, 2, 1_a]
            // where 1_a and 1_b are the same value.
            if i > 0 && nums[i] == nums[i - 1] && !used[i - 1] {
                continue;
            }

            used[i] = true;
            current_permutation.push(nums[i]);

            Self::backtrack(nums, used, current_permutation, result);

            current_permutation.pop();
            used[i] = false;
        }
    }
}