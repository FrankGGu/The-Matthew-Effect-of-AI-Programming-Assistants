impl Solution {
    pub fn divide_array(mut nums: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        nums.sort_unstable();
        let n = nums.len();
        let mut result: Vec<Vec<i32>> = Vec::new();

        for i in (0..n).step_by(3) {
            if nums[i+2] - nums[i] > k {
                return Vec::new();
            }
            result.push(vec![nums[i], nums[i+1], nums[i+2]]);
        }

        result
    }
}