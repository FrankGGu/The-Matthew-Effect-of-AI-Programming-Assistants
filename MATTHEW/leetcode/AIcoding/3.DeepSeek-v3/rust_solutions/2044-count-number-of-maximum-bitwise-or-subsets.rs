impl Solution {
    pub fn count_max_or_subsets(nums: Vec<i32>) -> i32 {
        let max_or = nums.iter().fold(0, |acc, &x| acc | x);
        let mut count = 0;
        let n = nums.len();

        for mask in 1..(1 << n) {
            let mut current_or = 0;
            for i in 0..n {
                if mask & (1 << i) != 0 {
                    current_or |= nums[i];
                }
            }
            if current_or == max_or {
                count += 1;
            }
        }

        count
    }
}