impl Solution {
    pub fn incremovable_subarray_count(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut left = 0;
        while left + 1 < n && nums[left] < nums[left + 1] {
            left += 1;
        }
        if left == n - 1 {
            return (n * (n + 1) / 2) as i64;
        }
        let mut right = n - 1;
        while right > 0 && nums[right - 1] < nums[right] {
            right -= 1;
        }
        let mut res = (left + 2) as i64;
        let mut i = left as i32;
        let mut j = right;
        while i >= 0 && j < n {
            if nums[i as usize] < nums[j] {
                res += (n - j) as i64;
                i -= 1;
            } else {
                j += 1;
            }
        }
        res
    }
}