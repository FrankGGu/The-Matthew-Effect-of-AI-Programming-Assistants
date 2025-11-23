impl Solution {
    pub fn min_deletion(nums: Vec<i32>) -> i32 {
        let mut res = 0;
        let mut i = 0;
        let n = nums.len();
        while i < n {
            if i + 1 < n && nums[i] == nums[i + 1] {
                res += 1;
                i += 1;
            } else {
                i += 2;
            }
        }
        res
    }
}