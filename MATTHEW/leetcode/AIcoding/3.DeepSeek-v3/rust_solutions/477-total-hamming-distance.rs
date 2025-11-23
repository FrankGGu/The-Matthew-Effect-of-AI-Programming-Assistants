impl Solution {
    pub fn total_hamming_distance(nums: Vec<i32>) -> i32 {
        let mut total = 0;
        let n = nums.len() as i32;
        for i in 0..32 {
            let mut count = 0;
            for &num in &nums {
                count += (num >> i) & 1;
            }
            total += count * (n - count);
        }
        total
    }
}