pub struct Solution {}

impl Solution {
    pub fn total_hamming_distance(nums: Vec<i32>) -> i32 {
        let mut total = 0;
        for i in 0..32 {
            let mut count = 0;
            for &num in &nums {
                if (num >> i) & 1 == 1 {
                    count += 1;
                }
            }
            total += count * (nums.len() as i32 - count);
        }
        total
    }
}