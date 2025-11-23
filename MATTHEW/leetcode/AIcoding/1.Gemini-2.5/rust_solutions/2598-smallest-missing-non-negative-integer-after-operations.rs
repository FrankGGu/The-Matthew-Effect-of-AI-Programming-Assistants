impl Solution {
    pub fn smallest_missing_non_negative_integer(nums: Vec<i32>, value: i32) -> i32 {
        let mut rem_counts: Vec<i32> = vec![0; value as usize];

        for num in nums {
            let remainder = num % value;
            rem_counts[remainder as usize] += 1;
        }

        for k in 0..value {
            if rem_counts[k as usize] == 0 {
                return k;
            }
        }

        value
    }
}