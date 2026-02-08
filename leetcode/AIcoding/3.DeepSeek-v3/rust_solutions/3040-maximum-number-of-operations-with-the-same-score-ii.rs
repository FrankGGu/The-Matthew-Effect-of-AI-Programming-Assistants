use std::collections::HashMap;

impl Solution {
    pub fn max_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return 0;
        }

        let mut memo = HashMap::new();

        let res1 = Self::dfs(&nums[2..], nums[0] + nums[1], &mut memo) + 1;
        let res2 = Self::dfs(&nums[1..n-1], nums[0] + nums[n-1], &mut memo) + 1;
        let res3 = Self::dfs(&nums[..n-2], nums[n-2] + nums[n-1], &mut memo) + 1;

        res1.max(res2).max(res3)
    }

    fn dfs(nums: &[i32], target: i32, memo: &mut HashMap<(usize, usize, i32), i32>) -> i32 {
        let n = nums.len();
        if n < 2 {
            return 0;
        }

        let key = (0, n, target);
        if let Some(&res) = memo.get(&key) {
            return res;
        }

        let mut res = 0;

        if nums[0] + nums[1] == target {
            res = res.max(Self::dfs(&nums[2..], target, memo) + 1);
        }
        if nums[0] + nums[n-1] == target {
            res = res.max(Self::dfs(&nums[1..n-1], target, memo) + 1);
        }
        if nums[n-2] + nums[n-1] == target {
            res = res.max(Self::dfs(&nums[..n-2], target, memo) + 1);
        }

        memo.insert(key, res);
        res
    }
}