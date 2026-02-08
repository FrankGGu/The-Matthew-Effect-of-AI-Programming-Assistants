impl Solution {
    pub fn smallest_range_i(nums: Vec<i32>, k: i32) -> i32 {
        let min_num = *nums.iter().min().unwrap();
        let max_num = *nums.iter().max().unwrap();
        let range = max_num - min_num;
        if range <= 2 * k {
            0
        } else {
            range - 2 * k
        }
    }
}