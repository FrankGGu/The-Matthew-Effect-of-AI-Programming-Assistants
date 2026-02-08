impl Solution {
    pub fn maximum_score(a: i32, b: i32, c: i32) -> i32 {
        let mut nums = vec![a, b, c];
        nums.sort();
        if nums[0] + nums[1] <= nums[2] {
            nums[0] + nums[1]
        } else {
            (a + b + c) / 2
        }
    }
}