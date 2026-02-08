impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i64 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mid = n / 2;
        let mut res = 0i64;

        for i in mid..n {
            if nums[i] < k {
                res += (k - nums[i]) as i64;
            } else {
                break;
            }
        }

        res
    }
}