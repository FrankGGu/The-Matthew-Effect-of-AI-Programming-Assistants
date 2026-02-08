impl Solution {
    pub fn max_num_of_marked_indices(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let n = nums.len();
        let mut res = 0;
        let mut j = n / 2;
        for i in 0..n / 2 {
            while j < n && nums[i] * 2 > nums[j] {
                j += 1;
            }
            if j < n {
                res += 2;
                j += 1;
            } else {
                break;
            }
        }
        res
    }
}