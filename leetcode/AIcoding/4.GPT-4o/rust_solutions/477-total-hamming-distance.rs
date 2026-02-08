impl Solution {
    pub fn total_hamming_distance(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut total_distance = 0;

        for i in 0..32 {
            let count_ones = nums.iter().filter(|&&x| (x >> i) & 1 == 1).count();
            total_distance += count_ones * (n - count_ones) as i32;
        }

        total_distance
    }
}