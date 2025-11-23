impl Solution {
    pub fn max_strength(nums: Vec<i32>) -> i64 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut max_strength = nums[0] as i64;
        for i in 1..=n {
            for j in 0..=n - i {
                let mut current = 1i64;
                for k in j..j + i {
                    current *= nums[k] as i64;
                }
                if current > max_strength {
                    max_strength = current;
                }
            }
        }
        max_strength
    }
}