impl Solution {
    pub fn matrix_sum(mut nums: Vec<Vec<i32>>) -> i32 {
        for row in nums.iter_mut() {
            row.sort();
        }
        let m = nums.len();
        let n = nums[0].len();
        let mut sum = 0;
        for j in 0..n {
            let mut max_val = 0;
            for i in 0..m {
                max_val = max_val.max(nums[i][j]);
            }
            sum += max_val;
        }
        sum
    }
}