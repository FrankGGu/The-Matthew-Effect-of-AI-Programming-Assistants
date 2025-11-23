impl Solution {
    pub fn is_good(nums: Vec<i32>) -> bool {
        let n = nums.len();
        let mut sorted_nums = nums.clone();
        sorted_nums.sort();

        for i in 0..n - 1 {
            if sorted_nums[i] != (i as i32) + 1 {
                return false;
            }
        }

        sorted_nums[n - 1] == (n - 1) as i32
    }
}