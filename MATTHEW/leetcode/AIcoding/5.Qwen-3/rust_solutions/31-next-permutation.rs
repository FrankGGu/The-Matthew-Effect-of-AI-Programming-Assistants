impl Solution {
    pub fn next_permutation(nums: &mut Vec<i32>) {
        let n = nums.len();
        let mut i = n as isize - 2;

        while i >= 0 && nums[i as usize] >= nums[i as usize + 1] {
            i -= 1;
        }

        if i >= 0 {
            let mut j = n as isize - 1;
            while nums[j as usize] <= nums[i as usize] {
                j -= 1;
            }
            nums.swap(i as usize, j as usize);
        }

        let mut left = i + 1;
        let mut right = n as isize - 1;
        while left < right {
            nums.swap(left as usize, right as usize);
            left += 1;
            right -= 1;
        }
    }
}