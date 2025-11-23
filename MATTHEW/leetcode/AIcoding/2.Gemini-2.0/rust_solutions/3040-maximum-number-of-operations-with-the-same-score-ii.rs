impl Solution {
    pub fn max_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut memo = vec![vec![-1; n]; n];

        fn solve(nums: &Vec<i32>, i: usize, j: usize, target: i32, memo: &mut Vec<Vec<i32>>) -> i32 {
            if i >= j {
                return 0;
            }

            if memo[i][j] != -1 {
                return memo[i][j];
            }

            let mut ans = 0;

            if nums[i] + nums[i + 1] == target {
                ans = ans.max(1 + solve(nums, i + 2, j, target, memo));
            }
            if nums[j] + nums[j - 1] == target {
                ans = ans.max(1 + solve(nums, i, j - 2, target, memo));
            }
            if nums[i] + nums[j] == target {
                ans = ans.max(1 + solve(nums, i + 1, j - 1, target, memo));
            }

            memo[i][j] = ans;
            ans
        }

        let mut ans = 0;
        ans = ans.max(solve(&nums, 0, n - 1, nums[0] + nums[1], &mut memo.clone()));
        ans = ans.max(solve(&nums, 0, n - 1, nums[n - 1] + nums[n - 2], &mut memo.clone()));
        ans = ans.max(solve(&nums, 0, n - 1, nums[0] + nums[n - 1], &mut memo.clone()));

        ans
    }
}