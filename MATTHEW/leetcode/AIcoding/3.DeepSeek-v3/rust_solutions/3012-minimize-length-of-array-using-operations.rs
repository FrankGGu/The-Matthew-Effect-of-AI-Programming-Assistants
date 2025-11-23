impl Solution {
    pub fn minimum_array_length(nums: Vec<i32>) -> i32 {
        let min_val = *nums.iter().min().unwrap();
        let count = nums.iter().filter(|&&x| x == min_val).count();
        if nums.iter().any(|&x| x % min_val != 0) {
            1
        } else {
            (count + 1) / 2
        }
    }
}