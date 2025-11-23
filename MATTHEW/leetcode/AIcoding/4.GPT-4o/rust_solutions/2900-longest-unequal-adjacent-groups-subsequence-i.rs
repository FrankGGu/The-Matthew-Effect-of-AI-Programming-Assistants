impl Solution {
    pub fn longest_unequal_adjacent_groups(nums: Vec<i32>) -> i32 {
        let mut max_length = 0;
        let n = nums.len();

        for i in 0..n {
            let mut length = 1;
            for j in (i + 1)..n {
                if nums[j] != nums[j - 1] {
                    length += 1;
                } else {
                    break;
                }
            }
            max_length = max_length.max(length);
        }
        max_length
    }
}