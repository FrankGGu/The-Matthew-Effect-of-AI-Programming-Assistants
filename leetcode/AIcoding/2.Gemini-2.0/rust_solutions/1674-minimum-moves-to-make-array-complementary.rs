impl Solution {
    pub fn min_moves(nums: Vec<i32>, limit: i32) -> i32 {
        let n = nums.len();
        let mut diff = vec![0; 2 * limit as usize + 2];
        for i in 0..n / 2 {
            let a = nums[i];
            let b = nums[n - 1 - i];
            diff[(1 + std::cmp::min(a, b)) as usize] += 1;
            diff[(std::cmp::min(a, b) + std::cmp::max(a, b) + 1) as usize] -= 1;
            diff[(a + b) as usize] -= 1;
            diff[(a + b + 1) as usize] += 1;
            diff[(a + b) as usize + 1] += 1;
            diff[(std::cmp::max(a, b) + limit + 1) as usize] -= 1;
        }

        let mut ans = n as i32;
        let mut curr = 0;
        for i in 2..=2 * limit as usize {
            curr += diff[i];
            ans = std::cmp::min(ans, (n / 2) as i32 - curr);
        }
        ans
    }
}