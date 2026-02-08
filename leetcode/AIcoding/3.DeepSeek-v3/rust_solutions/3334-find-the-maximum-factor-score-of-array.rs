impl Solution {
    pub fn max_score(nums: Vec<i32>) -> i64 {
        let mut nums = nums;
        nums.sort_by(|a, b| b.cmp(a));
        let mut prefix_sum = 0i64;
        let mut res = 0i64;
        for &num in nums.iter() {
            prefix_sum += num as i64;
            if prefix_sum > 0 {
                res += 1;
            } else {
                break;
            }
        }
        res
    }
}