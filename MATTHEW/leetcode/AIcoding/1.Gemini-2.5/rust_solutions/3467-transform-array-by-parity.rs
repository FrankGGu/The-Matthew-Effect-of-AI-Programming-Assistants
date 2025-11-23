impl Solution {
    pub fn sort_array_by_parity(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        let mut i = 0;
        let mut j = (nums.len() as isize) - 1;

        while i < j {
            if nums[i as usize] % 2 == 0 {
                i += 1;
            } else if nums[j as usize] % 2 != 0 {
                j -= 1;
            } else {
                nums.swap(i as usize, j as usize);
                i += 1;
                j -= 1;
            }
        }
        nums
    }
}