struct Solution {}

impl Solution {
    pub fn sort_colors(nums: &mut Vec<i32>) {
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;
        let mut i = 0;

        while i <= right {
            match nums[i as usize] {
                0 => {
                    nums.swap(i, left);
                    left += 1;
                    i += 1;
                },
                2 => {
                    nums.swap(i, right);
                    right -= 1;
                },
                _ => {
                    i += 1;
                }
            }
        }
    }
}