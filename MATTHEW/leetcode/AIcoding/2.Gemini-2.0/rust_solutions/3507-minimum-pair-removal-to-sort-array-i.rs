impl Solution {
    pub fn minimum_pair_removal(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;
        let mut i = 0;
        while i < n - 1 {
            if nums[i] > nums[i + 1] {
                count += 1;
                i += 2;
            } else {
                i += 1;
            }
        }
        count as i32
    }
}