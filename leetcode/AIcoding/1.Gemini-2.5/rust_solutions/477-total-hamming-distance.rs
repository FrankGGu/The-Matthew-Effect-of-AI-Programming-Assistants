struct Solution;

impl Solution {
    pub fn total_hamming_distance(nums: Vec<i32>) -> i32 {
        let mut total_distance = 0;
        let n = nums.len();

        for i in 0..32 { // Iterate through each bit position (0 to 31 for i32)
            let mut count_zeros = 0;
            let mut count_ones = 0;

            for &num in nums.iter() {
                if (num >> i) & 1 == 1 {
                    count_ones += 1;
                } else {
                    count_zeros += 1;
                }
            }
            total_distance += count_zeros * count_ones;
        }

        total_distance
    }
}