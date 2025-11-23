impl Solution {
    pub fn max_number_of_marked_indices(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut i = 0;
        let mut j = (n + 1) / 2;
        let mut count = 0;
        while i < n / 2 && j < n {
            if nums[i] * 2 <= nums[j] {
                count += 2;
                i += 1;
                j += 1;
            } else {
                j += 1;
            }
        }
        count
    }
}