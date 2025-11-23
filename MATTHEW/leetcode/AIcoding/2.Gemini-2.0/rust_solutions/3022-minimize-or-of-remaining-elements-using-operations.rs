impl Solution {
    pub fn minimize_xor(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut ans = i32::MAX;
        for i in 0..(1 << n) {
            if i.count_ones() as i32 == k {
                let mut current_or = 0;
                for j in 0..n {
                    if (i >> j) & 1 == 0 {
                        current_or |= nums[j];
                    }
                }
                ans = ans.min(current_or);
            }
        }
        ans
    }
}