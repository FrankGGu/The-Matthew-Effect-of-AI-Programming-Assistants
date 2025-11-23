struct Solution;

impl Solution {
    fn is_perfect_square(n: i32) -> bool {
        if n < 0 {
            return false;
        }
        let s = (n as f64).sqrt() as i32;
        s * s == n
    }

    pub fn num_squareful_arrays(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();
        let n = nums.len();
        let mut count = 0;
        let mut path = Vec::with_capacity(n);
        let mut visited = vec![false; n];

        Self::backtrack(&nums, &mut visited, &mut path, &mut count);

        count
    }

    fn backtrack(
        nums: &[i32],
        visited: &mut Vec<bool>,
        path: &mut Vec<i32>,
        count: &mut i32,
    ) {
        if path.len() == nums.len() {
            *count += 1;
            return;
        }

        for i in 0..nums.len() {
            if visited[i] {
                continue;
            }

            // Skip duplicates: If the current number is the same as the previous one,
            // and the previous one was not visited, it means we are trying to start
            // a new permutation branch with an identical number that has already
            // been considered (or could be considered) as a starting point (or next element).
            // This prevents redundant permutations.
            if i > 0 && nums[i] == nums[i - 1] && !visited[i - 1] {
                continue;
            }

            if !path.is_empty() {
                let last_val = *path.last().unwrap();
                if !Self::is_perfect_square(last_val + nums[i]) {
                    continue;
                }
            }

            visited[i] = true;
            path.push(nums[i]);
            Self::backtrack(nums, visited, path, count);
            path.pop();
            visited[i] = false;
        }
    }
}