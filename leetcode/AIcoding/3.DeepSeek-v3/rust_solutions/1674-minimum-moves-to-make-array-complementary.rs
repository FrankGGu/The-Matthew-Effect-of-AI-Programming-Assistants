impl Solution {
    pub fn min_moves(nums: Vec<i32>, limit: i32) -> i32 {
        let n = nums.len();
        let mut delta = vec![0; 2 * limit as usize + 2];
        for i in 0..n / 2 {
            let a = nums[i];
            let b = nums[n - 1 - i];
            let left = 2;
            let right = 2 * limit;
            delta[left as usize] += 2;
            delta[(a + b) as usize] -= 1;
            delta[(a + b + 1) as usize] += 1;
            delta[(right + 1) as usize] += 2;
            delta[(std::cmp::min(a, b) + 1) as usize] -= 1;
            delta[(std::cmp::max(a, b) + limit + 1) as usize] += 1;
        }
        let mut res = i32::MAX;
        let mut curr = 0;
        for sum in 2..=(2 * limit) {
            curr += delta[sum as usize];
            if curr < res {
                res = curr;
            }
        }
        res
    }
}