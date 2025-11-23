impl Solution {
    pub fn next_permutation(nums: &mut Vec<i32>) {
        let n = nums.len();
        if n <= 1 {
            return;
        }

        let mut k = n as isize - 2;
        while k >= 0 && nums[k as usize] >= nums[k as usize + 1] {
            k -= 1;
        }

        if k < 0 {
            nums.reverse();
            return;
        }

        let mut l = n - 1;
        while nums[k as usize] >= nums[l] {
            l -= 1;
        }

        nums.swap(k as usize, l);

        let mut left = k as usize + 1;
        let mut right = n - 1;
        while left < right {
            nums.swap(left, right);
            left += 1;
            right -= 1;
        }
    }
}