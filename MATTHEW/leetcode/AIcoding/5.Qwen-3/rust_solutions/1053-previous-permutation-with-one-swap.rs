impl Solution {
    pub fn prev_perm_opt1(nums: &mut Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut i = n - 1;
        while i > 0 && nums[i - 1] <= nums[i] {
            i -= 1;
        }
        if i == 0 {
            return nums.clone();
        }
        let mut j = n - 1;
        while nums[j] >= nums[i - 1] {
            j -= 1;
        }
        nums.swap(i - 1, j);
        nums.clone()
    }
}