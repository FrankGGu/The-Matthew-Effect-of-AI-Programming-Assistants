impl Solution {
    pub fn sort_array_by_parity(mut nums: Vec<i32>) -> Vec<i32> {
        let mut left = 0;
        let mut right = nums.len() as i32 - 1;

        while left < right {
            if nums[left as usize] % 2 == 0 {
                left += 1;
            } else if nums[right as usize] % 2 != 0 {
                right -= 1;
            } else {
                nums.swap(left as usize, right as usize);
                left += 1;
                right -= 1;
            }
        }
        nums
    }
}