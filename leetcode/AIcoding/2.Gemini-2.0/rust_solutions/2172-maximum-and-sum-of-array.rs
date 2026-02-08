impl Solution {
    pub fn maximum_and_sum(nums: Vec<i32>, num_slots: i32) -> i32 {
        let n = nums.len();
        let m = num_slots as usize;
        let slots = m * 2;
        let mut dp = vec![vec![-1; 3_i32.pow(slots as u32) as usize]; n + 1];

        fn solve(nums: &Vec<i32>, slots: usize, index: usize, mask: usize, dp: &mut Vec<Vec<i32>>) -> i32 {
            if index == nums.len() {
                return 0;
            }

            if dp[index][mask] != -1 {
                return dp[index][mask];
            }

            let mut ans = 0;
            for i in 0..slots {
                if (mask / (3_i32.pow(i as u32) as usize)) % 3 != 0 {
                    let new_mask = mask + 3_i32.pow(i as u32) as usize;
                    ans = ans.max((nums[index] & ((i / 2) + 1) as i32) + solve(nums, slots, index + 1, new_mask, dp));
                }
            }

            dp[index][mask] = ans;
            ans
        }

        solve(&nums, m * 2, 0, 0, &mut dp)
    }
}